extends Area2D

var instance = preload("res://scenes/jeremiahbutgravity.tscn")
@onready var base_room: Node2D = $"../.."

func _on_body_entered(body: Node2D) -> void:
	print("woo")
	body.visible=false
	var jer = instance.instantiate()
	jer.global_position = (body.global_position)
	base_room.call_deferred("add_child",jer)
