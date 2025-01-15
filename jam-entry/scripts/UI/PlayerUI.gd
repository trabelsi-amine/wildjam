extends Control

@onready var state: Label = $State
@onready var player: Player = $"../../Player"

var time:float
var TimerEnabled := true

func _process(_delta: float) -> void:
	ShowInformationUI()
	RunTimer(_delta)
	DetectInterfaceInput()
	change_state()

func ShowInformationUI():
	ShowTime()

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

func DetectInterfaceInput():
	if Input.is_action_just_pressed("Pause"):
		$Pause.visible = true
		get_tree().paused = true
		TimerEnabled = false


func Quit() -> void:
	get_tree().quit()

func change_state():
	match player.current_state:
		player.STATES.Solid:
			state.text = "Solid"
		player.STATES.Liquid:
			state.text = "Liquid"
		player.STATES.Gas:
			state.text = "Gas"