class_name Player
extends CharacterBody2D

@onready var playerSprite: Sprite2D = $Sprite2D
@onready var respawn_marker: Marker2D = $"../Environment/RespawnMarker"

enum STATES {
	Solid,
	Liquid,
	Gas
}

var current_state = STATES.Solid


func _ready() -> void:
	global_position = respawn_marker.global_position


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

func solid_state(delta):
	#visual
	playerSprite.modulate.r = 255
	playerSprite.modulate.b = 0
	playerSprite.modulate.g = 0
	
	#movement
	var speed = 1200
	var gravity = 4000
	var jump_speed = -1800
		
	velocity.y += gravity * delta
	velocity.x = Input.get_axis("left", "right") * speed
	print(Input.get_axis("left", "right"))
		
	move_and_slide()
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = jump_speed
	
	

func liquid_state(delta):
	#visual
	playerSprite.modulate.r = 0
	playerSprite.modulate.b = 255
	playerSprite.modulate.g = 0
	
	#movement
	var speed = 1000
	var gravity = 4000
	
	velocity.y += gravity * delta
	velocity.x = Input.get_axis("left", "right") * speed
	move_and_slide()


func gas_state(delta):
	#visual
	playerSprite.modulate.r = 0
	playerSprite.modulate.b = 0
	playerSprite.modulate.g = 255
	
	#movement
	var speed = 650
	var gravity = 1000
	var jump_speed = -500
	
	velocity.y += gravity * delta
	velocity.x = Input.get_axis("left", "right") * speed
	move_and_slide()
	
	if Input.is_action_pressed("jump"):
		velocity.y = jump_speed

func change_state():
	match current_state:
		STATES.Solid:
			current_state = STATES.Liquid
		STATES.Liquid:
			current_state = STATES.Gas
		STATES.Gas:
			current_state = STATES.Solid
	


func teleport_back_to_spawn():
	global_position = respawn_marker.global_position
