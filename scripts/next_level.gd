extends Area2D


func Teleport(body: Node2D) -> void:
	if body.is_in_group("Player"):
		Global.player = null
		(get_tree().root.get_node("LevelManager") as LevelManager).NextLevel()
