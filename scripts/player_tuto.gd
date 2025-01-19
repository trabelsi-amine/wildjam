extends CharacterBody2D
#class_name Player

@export var rnd_shake_strength = 10.0
@export var shake_decay_rate = 7.5

@onready var playerSprite: Sprite2D = $Sprite2D
@onready var waterSprite = $Water
@onready var collision = $CollisionShape2D
@onready var liquid_collision = $LiquidCollision

@onready var respawn_marker: Marker2D = $"../Environment/RespawnMarker"
@onready var anim: AnimationPlayer = $AnimationPlayer
@onready var particles_scene = preload("res://scenes/gas.tscn")

@onready var camera = $"../Camera2D"

var speed = 500
var gravity = 1000
var jump_speed = -500

var rand
var shake_strength = 0.0

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
	
	rand = RandomNumberGenerator.new()
	rand.randomize()

func _process(delta):
	shake_strength = lerp(shake_strength, 0.0, shake_decay_rate * delta)
	camera.offset = get_random_offset()

func _physics_process(delta: float) -> void:
	manage_anims()
	solid_state(delta)

# Sets all solid state variables upon entering solid state
func enter_solid_state():
	apply_shake()
	# Solid form
	playerSprite.visible = true
	# Liquid form
	waterSprite.visible = false
	waterSprite.get_child(0).emitting = false # Only child
	# Gas form
	if(has_node("gas")):
		get_node("gas").queue_free()
	# Collision Shape
	collision.disabled = false
	liquid_collision.disabled = true
	# Collision layer is where the player is
	set_collision_layer(1) # 100 (True False False)
	# Collision mask is what the player detects
	set_collision_mask(1)
	# Movement variables
	speed = 500
	gravity = 1000
	jump_speed = -520

func solid_state(delta):
	velocity.x = Input.get_axis("left", "right") * speed
	
	velocity.y += gravity * delta
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = jump_speed
	if Input.is_action_just_released("jump"):
		velocity.y = 0
	
	test_colision()
	move_and_slide()

# Push movable box
var push_force = 50
var max_velocity = 100
func test_colision():
	for i in get_slide_collision_count():
		var test_collision = get_slide_collision(i)
		var collider = test_collision.get_collider()
		if collider.is_in_group("MovableBox") and abs(collider.get_linear_velocity().x) < max_velocity:
			collider.apply_central_impulse(test_collision.get_normal() * -push_force)

func teleport_back_to_spawn():
	global_position = respawn_marker.global_position

func manage_anims():
	if velocity.x < 0:
		# Look to the left
		playerSprite.flip_h = true
	else:
		if velocity.x>0:
			# Look to the right
			playerSprite.flip_h = false
	
	if is_on_floor():
		if abs(velocity.x) == 0:
			anim.play("idle")
		else:
			anim.play("run")
	else:
		if velocity.y < 0:
			anim.play("jump")
		else:
			anim.play("fall")

func apply_shake():
	shake_strength = rnd_shake_strength

func get_random_offset():
	return Vector2(
		rand.randf_range(-shake_strength, shake_strength),
		rand.randf_range(-shake_strength, shake_strength)
	)
