extends CPUParticles2D

@onready var parent = get_parent()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	global_position = parent.global_position
