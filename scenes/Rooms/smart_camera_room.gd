extends Node2D

@onready var player = $Player
@onready var camera = $Environment/camera
@onready var marker = $Environment/camera/Marker2D
@onready var pressure_plate = $Environment/PressurePlate2

func _process(_delta):
	if pressure_plate.pressed:
		camera.set_physics_process(false)
		camera.light.visible = false
	else:
		camera.set_physics_process(true)
		camera.light.visible = true
		
		marker.position = player.global_position - camera.global_position
		camera.look_at(player.global_position)
