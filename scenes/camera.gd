extends Node2D

@onready var target : Marker2D = $target
@onready var ray: RayCast2D = $RayCast2D
@onready var line: Line2D = $Line2D


func _physics_process(delta: float) -> void:
	ray.target_position = target.to_local(target.global_position)
	print(ray.get_collision_point())
	if(ray.is_colliding()):
		line.set_point_position(0,to_local(ray.get_collision_point()))
	else:
		line.set_point_position(0,to_local(target.global_position))
