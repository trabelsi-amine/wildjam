extends Node2D

### Atention ###
# This node DOES NOT HAVE a 2D marker as a child
# The marker2D must be added as a child of this node after being imported into a scene
# See example in main.tscn
# This way, it is easier to set a target for the camera, without changing the saved scene

@onready var ray: RayCast2D = $RayCast2D
@onready var target: Marker2D = $target
#@onready var line: Line2D = $Line2D

func _ready():
	look_at(target.global_position)

func _physics_process(_delta: float) -> void:
	#ray.target_position = target.to_local(target.global_position)
	#if(ray.is_colliding()):
		#line.set_point_position(0,to_local(ray.get_collision_point()))
	#else:
		#line.set_point_position(0,to_local(target.global_position))
	
	if ray.is_colliding():
		var body = ray.get_collider()
		if body.is_in_group("Player"):
			print("Hit player as %s form." % body.current_state)
