extends Node

var CurrentLevelIndex:int = -1
var Levels := ["res://scenes/main.tscn"]

func NextLevel():
	CurrentLevelIndex += 1
	get_tree().change_scene_to_file(Levels[CurrentLevelIndex])

func KillPlayer():
	get_tree().current_scene.get_node("Player").queue_free()
	(get_tree().current_scene.get_node("PlayerInterfaceCanvas/PlayerInterface") as PlayerUI)

func Restart():
	CurrentLevelIndex = -1
	NextLevel()
