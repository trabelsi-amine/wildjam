extends Control

var lb_path = "res://scenes/UI/leaderboard.tscn"

func _ready():
	get_tree().paused = false

func _on_play_button_up():
	var path = Global.get_level_path(1)
	get_tree().change_scene_to_file(path)

func _on_leaderboard_button_up():
	get_tree().change_scene_to_file(lb_path)

func _on_quit_button_up():
	get_tree().quit()
