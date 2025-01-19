class_name PlayerUI
extends Control

@onready var state: Label = $State
@onready var audio: AudioStreamPlayer2D = $AudioStreamPlayer2D

var player = null
var time:float
var TimerEnabled := true
var CurrentUIOpened := ""

func SendTimeToLevelManager():
	(get_tree().root.get_node("LevelManager") as LevelManager).Score = time

func _ready():
	get_tree().paused = false
	set_player_ref()

func set_player_ref():
	if Global.player: # Not null
		player = Global.player
	else:
		await get_tree().create_timer(0.5).timeout
		set_player_ref()

func _process(delta: float) -> void:
	ShowInformationUI()
	RunTimer(delta)
	DetectInterfaceInput()
	ProcessShortcuts()
	SendTimeToLevelManager()
	if(Input.is_action_just_pressed("restart")):
		get_tree().reload_current_scene()

func ShowInformationUI():
	ShowTime()
	ShowState()

func ProcessShortcuts():
	match CurrentUIOpened:
		"":
			pass
		"paused":
			if Input.is_key_pressed(KEY_R):
				ClosePause()
			if Input.is_key_pressed(KEY_Q):
				Quit()
		"death":
			if Input.is_key_pressed(KEY_R):
				CurrentUIOpened = ""
				(get_tree().root.get_node("LevelManager") as LevelManager).Restart()

## You can use this function for player's death.
func SpottedScreen():
	audio.play()
	CurrentUIOpened = "death"
	$Spotted.show()
	$Pause.hide()
	$State.hide()
	$Timer.hide()

func ShowTime():
	if str(time).contains("."):
		$Timer/Time.text = str(time).split(".")[0] + "." + str(time).split(".")[1].substr(0,2)
	else:
		$Timer/Time.text = str(time)

func RunTimer(delta:float):
	if TimerEnabled: time += delta

func ClosePause() -> void:
	$Pause.visible = false
	get_tree().paused = false
	TimerEnabled = true
	CurrentUIOpened = ""

func DetectInterfaceInput():
	if Input.is_action_just_pressed("Pause"):
		$Pause.visible = true
		get_tree().paused = true
		TimerEnabled = false
		CurrentUIOpened = "paused"

func Quit() -> void:
	CurrentUIOpened = ""
	(get_tree().root.get_node("LevelManager") as LevelManager).MainMenu = true
	(get_tree().root.get_node("LevelManager") as LevelManager).Restart()

func ShowState():
	if player: # Not null
		match player.current_state:
			player.STATES.Solid:
				state.text = "Solid"
			player.STATES.Liquid:
				state.text = "Liquid"
			player.STATES.Gas:
				state.text = "Gas"

func Lead():
	$Leaderboard.ShowLead()

func Restart() -> void:
	CurrentUIOpened = ""
	(get_tree().root.get_node("LevelManager") as LevelManager).RestartLvl()
