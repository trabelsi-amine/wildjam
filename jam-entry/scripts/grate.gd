extends StaticBody2D

@onready var collision = $CollisionShape2D

var player = null
var disabled = false

func _ready():
	get_player_ref()

# Get a reference to the player node
	# If this function is called before the player ref being set in the Global script, wait some time and tries again
func get_player_ref():
	if Global.player:
		player = Global.player
	else:
		await get_tree().create_timer(0.5).timeout
		get_player_ref()

func _process(_delta):
	# If the ref is not null
	if player:
		# If the player state is liquid
		if player.current_state == player.STATES.Liquid:
			# disable collision (so the player can pass through)
			disable_collision()
		else:
			enable_collision()

func enable_collision():
	# If it is already enabled, do nothing
	if not disabled:
		return
	# If really disabled, enable it
		# This way, it only accesses the collision once per change
	disabled = false
	collision.disabled = false

func disable_collision():
	# If it is already disabled, do nothing
	if disabled:
		return
	# If really enabled, disable it
		# This way, it only accesses the collision once per change
	disabled = true
	collision.disabled = true
