extends StaticBody2D

@export var pressure_plate : PressurePlate

@onready var sprite = $Sprite2D
@onready var occluder = $LightOccluder2D
@onready var collision = $CollisionShape2D

var open = false

func _process(_delta):
	if pressure_plate: # Not null
		# If the plate is pressed and the door is closed, open it
		if pressure_plate.pressed and not open:
			open_door()
		# If the plate is not pressed and the door is open, close it
		if not pressure_plate.pressed and open:
			close_door()

func open_door():
	open = true
	sprite.visible = false
	occluder.visible = false
	collision.disabled = true

func close_door():
	open = false
	sprite.visible = true
	occluder.visible = true
	collision.disabled = false
