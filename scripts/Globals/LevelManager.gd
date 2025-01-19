extends Node

var CurrentLevelIndex:int = 2
var Levels := [
	"res://scenes/Rooms/tutorial_room.tscn",
	"res://scenes/Rooms/horizontal_doors_room.tscn",
	"res://scenes/Rooms/moving_cameras_room_v2.tscn",
	"res://scenes/Rooms/traps_room.tscn",
	"res://scenes/main.tscn",
	"res://scenes/Rooms/smart_camera_room.tscn",
	"res://scenes/Rooms/outroroom.tscn"
]
var MainMenu:bool = true
var Score:float
var MainScore:float

#func _process(delta: float) -> void:
	#print(CurrentLevelIndex)

func NextLevel():
	CurrentLevelIndex = CurrentLevelIndex + 1
	#print(Levels[CurrentLevelIndex])
	call_deferred("NLDeffered")

func EndAndSubmit():
	MainScore = Score
	get_tree().change_scene_to_file("res://scenes/UI/submit_score.tscn")

func NLDeffered():
	get_tree().change_scene_to_file(Levels[CurrentLevelIndex])

func KillPlayer():
	get_tree().current_scene.get_node("Player").queue_free()
	(get_tree().current_scene.get_node("PlayerInterfaceCanvas/PlayerInterface") as PlayerUI)
	Global.player = null

func Restart():
	CurrentLevelIndex = -1
	NextLevel()

func RestartLvl():
	CurrentLevelIndex = CurrentLevelIndex - 1
	#get_tree().paused = false
	NextLevel()
