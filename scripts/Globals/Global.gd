extends Node

var player = null

# Levels path
const HORIZONTAL_DOORS_ROOM = "res://scenes/Rooms/horizontal_doors_room.tscn"
const MOVING_CAMERAS_ROOM_V_2 = "res://scenes/Rooms/moving_cameras_room_v2.tscn"
const SMART_CAMERA_ROOM = "res://scenes/Rooms/smart_camera_room.tscn"
const TRAPS_ROOM = "res://scenes/Rooms/traps_room.tscn"
const TUTORIAL_ROOM = "res://scenes/Rooms/tutorial_room.tscn"

func get_level_path(id):
	match id:
		1:
			return TUTORIAL_ROOM
		2:
			return TRAPS_ROOM
		3:
			return MOVING_CAMERAS_ROOM_V_2
		4:
			return HORIZONTAL_DOORS_ROOM
		5:
			return SMART_CAMERA_ROOM
