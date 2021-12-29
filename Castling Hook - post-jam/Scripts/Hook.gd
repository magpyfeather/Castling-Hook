extends Position2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var player

# Called when the node enters the scene tree for the first time.
func _ready():
	#player = get_parent().get_node("Player")
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if player != null:
		look_at(player.global_position)

func show_hook(target_pos, player_inst):
	if player == null:
		player = player_inst
	global_position = target_pos
	visible = true

func hide_hook():
	visible = false
