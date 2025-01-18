extends Area2D
class_name PressurePlate

@onready var sprite = $Sprite2D

# This flag is used for other nodes (such as a door) to check whether the plate is pressed or not
var pressed = false

func press_it():
	if pressed:
		return
	pressed = true
	sprite.scale.y = 0.1
	sprite.position.y = 6

func unpress_it():
	if not pressed:
		return
	pressed = false
	sprite.scale.y = 0.2
	sprite.position.y = 0

func _on_body_entered(body):
	# If the player or a box is inside the area, press it
	if body.is_in_group("Player") or body.is_in_group("MovableBox"):
		press_it()

func _on_body_exited(body):
	# If any body leaves the ‘pressure’ area, test to see if any body remains
	var some_body_remains = false
	var bodies = get_overlapping_bodies()
	for b in bodies:
		if b.is_in_group("Player") or b.is_in_group("MovableBox"):
			some_body_remains = true
			break
	
	if some_body_remains:
		# If there is any left, press it
		press_it()
	else:
		# If there are none left, unpress it
		unpress_it()
