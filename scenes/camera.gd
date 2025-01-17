extends Node2D

### Atention ###
# This node DOES NOT HAVE a 2D marker as a child
# The marker2D must be added as a child of this node after being imported into a scene
# See example in main.tscn
# This way, it is easier to set a target for the camera, without changing the saved scene

@onready var light = $PointLight2D
@onready var ray: RayCast2D = $RayCast2D
@onready var target: Marker2D = $target

var player = null
# Used for look at the center of the player sprite instead of the bottom
var player_offset = Vector2(0, -30)
# Limit rotation for the raycast (around 9º for each side)
var light_angle = 0.17 #deg_to_rad(9.0)
# If true, change light color
var seeing_player = false
# Color when player is not being seen
var ok_color = Color.SEA_GREEN
# Color when player is being seen
var hit_color = Color.FIREBRICK

func _ready():
	look_at(target.global_position)
	set_player_ref()

func set_player_ref():
	if Global.player: # Not null
		player = Global.player
	else:
		await get_tree().create_timer(0.5).timeout
		set_player_ref()

func _physics_process(_delta: float) -> void:
	# Reset vars to default. If the player is not within range of the light, nothing changes
	seeing_player = false
	ray.rotation = 0
	
	if player: # Not null
		# Vector to the target (middle of the light)
		var view_vec = target.global_position
		# Vector to the player
		var player_vec = player.global_position + player_offset - global_position
		# The camera is rotated by the look_at method in the _ready function
			# So now I 'remove' this rotation of the vector to the player
		player_vec = player_vec.rotated(-rotation)
		# Calculate the angle between the two vectors
		var angle = view_vec.angle_to(player_vec)
		#print(view_vec, " ", player_vec, " ", angle)
		
		# If (unsigned) angle is <= than limit
		if abs(angle) <= light_angle:
			# RayCast rotates to look at the player
			ray.look_at(player.global_position + player_offset)
			
			### DEBUG Only
			# Vector to the target
			#$LineView.remove_point(1)
			#$LineView.add_point(view_vec)
			# Vector to the player
			#$LinePlayer.remove_point(1)
			#$LinePlayer.add_point(player_vec)
	
	# If RayCast hits something...
	if ray.is_colliding():
		var body = ray.get_collider()
		# If it's hitting the player
		if body.is_in_group("Player"):
			# Sets flag
			seeing_player = true
			#print("Hit player as %s form." % body.current_state)
	
	# Sets the color of the light depending on whether the player is being seen or not
	if seeing_player:
		light.color = hit_color
	else:
		light.color = ok_color
