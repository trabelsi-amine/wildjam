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
			liquid_state()
		STATES.Gas:
			gas_state()

func solid_state(delta):
	playerSprite.modulate.r = 255
	playerSprite.modulate.b = 0
	playerSprite.modulate.g = 0
	
	solid_movement(delta)
	
	

func solid_movement(delta):
	var speed = 500
	var gravity = 1000
	var jump_speed = -500
		
	velocity.y += gravity * delta
	velocity.x = Input.get_axis("left", "right") * speed
	#print(Input.get_axis("left", "right"))
		
	move_and_slide()
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = jump_speed

func liquid_state():
	playerSprite.modulate.r = 0
	playerSprite.modulate.b = 255
	playerSprite.modulate.g = 0



func gas_state():
	playerSprite.modulate.r = 0
	playerSprite.modulate.b = 0
	playerSprite.modulate.g = 255

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
