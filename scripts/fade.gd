extends Sprite2D

var fade:int = 255

func TheEndAnimation(name:StringName):
	get_parent().get_parent().get_node("lightmaker/Area2D").ShowText()
	$Timer.start()


func _on_timer_timeout() -> void:
	fade -= 5*7
	self_modulate = Color8(255,255,255,fade)
	if fade <= 0:
		(get_tree().root.get_node("LevelManager") as LevelManager).EndAndSubmit()
