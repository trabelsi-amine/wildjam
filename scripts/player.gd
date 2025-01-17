class_name Player
extends CharacterBody2D

@onready var playerSprite: Sprite2D = $Sprite2D
@onready var respawn_marker: Marker2D = $"../Environment/RespawnMarker"
@onready var anim: AnimationPlayer = $AnimationPlayer

var speed = 500
var gravity = 1000
var jump_speed = -500

enum STATES {
	Solid,
	Liquid,
	Gas
}

var current_state = STATES.Solid

func _ready() -> void:
	# Sets a reference to the player in the Global script, facilitating access by other nodes
	Global.player = self
	# Moves player to the marker position
	global_position = respawn_marker.global_position
	# Sets some variables, like color, to the solid state
	enter_solid_state()

func _physics_process(delta: float) -> void:
	if Input.is_action_just_pressed("ChangeState"):
		change_state()
	
	#manage state stuff
	manage_anims()
	manage_states(delta)

func manage_states(delta):
	match current_state:
		STATES.Solid:
			solid_state(delta)
		STATES.Liquid:
			liquid_state(delta)
		STATES.Gas:
			gas_state(delta)

# Sets all solid state variables upon entering solid state
func enter_solid_state():
	# Sprite color
	playerSprite.modulate = Color.RED
	# Collision layer is where the player is
	set_collision_layer(1) # 100 (True False False)
	# Collision mask is what the player detects
	set_collision_mask(1)
	# Movement variables
	speed = 500
	gravity = 1000
	jump_speed = -500

func solid_state(delta):
	velocity.x = Input.get_axis("left", "right") * speed
	
	velocity.y += gravity * delta
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = jump_speed
	
	test_colision()
	move_and_slide()

# Sets all liquid state variables upon entering liquid state
func enter_liquid_state():
	playerSprite.modulate = Color.BLUE
	set_collision_layer(2) # 010 (False True False)
	set_collision_mask(2)
	speed = 500
	gravity = 4000

func liquid_state(delta):
	velocity.x = Input.get_axis("left", "right") * speed
	velocity.y += gravity * delta
	
	test_colision()
	move_and_slide()

# Sets all gas state variables upon entering gas state
func enter_gas_state():
	playerSprite.modulate = Color.GREEN
	set_collision_layer(4) # 001 (False False True)
	set_collision_mask(4)
	speed = 250
	gravity = -250
	jump_speed = -250

func gas_state(delta):
	#velocity.x = Input.get_axis("left", "right") * speed
	var hor_input = Input.get_axis("left", "right")
	velocity.x += hor_input * speed
	velocity.x = clamp(velocity.x, -speed, speed)
	if not hor_input: # No input
		velocity.x = move_toward(velocity.x, 0.0, speed)
	
	velocity.y += gravity * delta
	if Input.is_action_just_pressed("jump"):
		velocity.y = jump_speed
	
	move_and_slide()

var push_force = 50
var max_velocity = 100
func test_colision():
	for i in get_slide_collision_count():
		var collision = get_slide_collision(i)
		var collider = collision.get_collider()
		if collider.is_in_group("MovableBox") and abs(collider.get_linear_velocity().x) < max_velocity:
			collider.apply_central_impulse(collision.get_normal() * -push_force)

# Called by the Fan node
var blown_force = 80
func be_blown_away(dir):
	if current_state == STATES.Gas:
		velocity += blown_force * dir

func change_state():
	match current_state:
		STATES.Solid:
			enter_liquid_state()
			current_state = STATES.Liquid
		STATES.Liquid:
			enter_gas_state()
			current_state = STATES.Gas
		STATES.Gas:
			enter_solid_state()
			current_state = STATES.Solid

func teleport_back_to_spawn():
	global_position = respawn_marker.global_position

func manage_anims():
	if is_on_floor():
		if abs(velocity.x) == 0:
			anim.play("idle")
		else:
			anim.play("run")
			if velocity.x < 0:
				# Look to the left
				playerSprite.flip_h = true
			else:
				# Look to the right
				playerSprite.flip_h = false
