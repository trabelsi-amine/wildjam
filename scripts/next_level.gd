extends Area2D



func Teleport(body: Node2D) -> void:
	if body is player:
		(get_tree().root.get_node("LevelManager") as LevelManager).NextLevel()
