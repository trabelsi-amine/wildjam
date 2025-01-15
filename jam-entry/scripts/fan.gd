extends StaticBody2D

@onready var marker = $Marker2D

# The player node will be valid as long as the player is inside the Area2d collision
var player = null

func _process(delta):
	# If player is valid, is in the gas state and has method, call method
	if player:
		if player.current_state == player.STATES.Gas and player.has_method("be_blown_away"):
			var dir = (marker.global_position - global_position).normalized()
			player.be_blown_away(dir)

func _on_area_2d_body_entered(body):
	if body.is_in_group("Player"):
		player = body

func _on_area_2d_body_exited(body):
	if body.is_in_group("Player"):
		player = null