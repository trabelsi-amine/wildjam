class_name Player
extends CharacterBody2D

@onready var playerSprite: Sprite2D = $Sprite2D
@onready var respawn_marker: Marker2D = $"../Environment/RespawnMarker"

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
	Global.player = self
	#global_position = respawn_marker.global_position

func _physics_process(delta: float) -> void:
	if Input.is_action_just_pressed("ChangeState"):
		change_state()
	
	#manage state stuff
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
	#playerSprite.modulate.r = 255
	#playerSprite.modulate.b = 0
	#playerSprite.modulate.g = 0
	
	solid_movement(delta)

func solid_movement(delta):
	#set_collision_layer_value(1,true)#solid
	#set_collision_layer_value(2,false)#liquid
	#set_collision_layer_value(3,false)#gas
	
	#var speed = 500
	#var gravity = 1000
	#var jump_speed = -500
		
	velocity.y += gravity * delta
	velocity.x = Input.get_axis("left", "right") * speed
	#print(Input.get_axis("left", "right"))
		
	move_and_slide()
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = jump_speed

# Sets all liquid state variables upon entering liquid state
func enter_liquid_state():
	playerSprite.modulate = Color.BLUE
	set_collision_layer(2) # 010 (False True False)
	set_collision_mask(2)
	speed = 1000
	gravity = 4000

func liquid_state(delta):
	
	#playerSprite.modulate.r = 0
	#playerSprite.modulate.b = 255
	#playerSprite.modulate.g = 0
#
	#set_collision_layer_value(1,false)#solid
	#set_collision_layer_value(2,true)#liquid
	#set_collision_layer_value(3,false)#gas
	
	#movement
	#var speed = 1000
	#var gravity = 4000
	
	velocity.y += gravity * delta
	velocity.x = Input.get_axis("left", "right") * speed
	move_and_slide()

# Sets all gas state variables upon entering gas state
func enter_gas_state():
	playerSprite.modulate = Color.GREEN
	set_collision_layer(4) # 001 (False False True)
	set_collision_mask(4)
	speed = 250
	gravity = 500
	jump_speed = -250

func gas_state(delta):
	#set_collision_layer_value(1,false)#solid
	#set_collision_layer_value(2,false)#liquid
	#set_collision_layer_value(3,true)#gas
	#
	#
	#playerSprite.modulate.r = 0
	#playerSprite.modulate.b = 0
	#playerSprite.modulate.g = 255
	
	#const speed = 250
	#const gravity = 500
	#const jump_speed = -250
		
	velocity.y += gravity * delta
	#velocity.x = Input.get_axis("left", "right") * speed
	var hor_input = Input.get_axis("left", "right")
	velocity.x += hor_input * speed
	velocity.x = clamp(velocity.x, -speed, speed)
	if not hor_input: # No input
		velocity.x = move_toward(velocity.x, 0.0, speed)
	#print(Input.get_axis("left", "right"))
		
	move_and_slide()
	if Input.is_action_just_pressed("jump"):
		velocity.y = jump_speed

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
