extends Area2D

func _physics_process(_delta: float) -> void:
	var overlapping_bodies = get_overlapping_bodies()
	for body in overlapping_bodies:
		if body.is_in_group("Player"):
			if body.has_method("teleport_back_to_spawn"):
				body.teleport_back_to_spawn()
