extends Path2D

@onready var path_follow = $PathFollow2D
@onready var camera = $"../camera"
@onready var camera2 = $"../camera6"

var to_right = true
var progress_vle = 0.5
var speed = 0.8
var idle_time = 0.8
var stopped = false

func _physics_process(delta):
	if stopped:
		return
	
	if to_right:
		progress_vle += speed * delta
		if progress_vle >= 1.0:
			progress_vle = 1.0
			to_right = false
			stopped = true
			stop()
	else:
		progress_vle -= speed * delta
		if progress_vle <= 0.0:
			progress_vle = 0.0
			to_right = true
			stopped = true
			stop()
	
	path_follow.progress_ratio = progress_vle
	camera.global_position = path_follow.global_position
	camera2.global_position.x = 1152 - path_follow.global_position.x

func stop():
	await get_tree().create_timer(idle_time).timeout
	stopped = false
