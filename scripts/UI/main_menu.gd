extends Control

func _ready() -> void:
	if (!((get_tree().root.get_node("LevelManager") as LevelManager).MainMenu)): return
	get_parent().TimerEnabled = false
	show()
	call_deferred("ReadyDeffered")

func ReadyDeffered():
	get_tree().paused = true

func Play() -> void:
	(get_tree().root.get_node("LevelManager") as LevelManager).MainMenu = false
	hide()
	get_tree().paused = false
	get_parent().TimerEnabled = true

func Quit():
	get_tree().quit()

func Lead():
	get_parent().Lead()
