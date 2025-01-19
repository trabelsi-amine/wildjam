extends Node

var CurrentLevelIndex:int = 0
var Levels := [
	"res://scenes/Rooms/tutorial_room.tscn",
]
var MainMenu:bool = true
var Score:float
var MainScore:float

func _process(delta: float) -> void:
	print(CurrentLevelIndex)

func NextLevel():
	CurrentLevelIndex = CurrentLevelIndex + 1
	print(Levels[CurrentLevelIndex])
	call_deferred("NLDeffered")

func EndAndSubmit():
	MainScore = Score
	get_tree().change_scene_to_file("res://scenes/UI/submit_score.tscn")

func NLDeffered():
	get_tree().change_scene_to_file(Levels[CurrentLevelIndex])

func KillPlayer():
	get_tree().current_scene.get_node("Player").queue_free()
	(get_tree().current_scene.get_node("PlayerInterfaceCanvas/PlayerInterface") as PlayerUI).SpottedScreen()

func Restart():
	get_tree().paused = false
	CurrentLevelIndex = -1
	NextLevel()

func RestartLvl():
	get_tree().paused = false
	NextLevel()
