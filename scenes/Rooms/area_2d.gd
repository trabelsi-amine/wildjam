extends Area2D

var instance = preload("res://scenes/jeremiahbutgravity.tscn")
@onready var base_room: Node2D = $"../.."

var flag = false

func _on_body_entered(body: Node2D) -> void:
	get_parent().get_parent().get_node("PlayerInterfaceCanvas/PlayerInterface").TimerEnabled = false
	if flag:
		return
	flag = true
	print("woo")
	body.visible=false
	body.set_physics_process(false)
	var jer = instance.instantiate()
	jer.global_position = (body.global_position + Vector2(0, -96))
	base_room.call_deferred("add_child",jer)

func ShowText():
	$"../../sacrifice".show()
