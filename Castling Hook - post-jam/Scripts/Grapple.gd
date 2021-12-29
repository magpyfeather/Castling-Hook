extends Line2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var player
var target = Vector2()

# Called when the node enters the scene tree for the first time.
func _ready():
	#player = get_parent().get_node("Player")
	pass # Replace with function body.


func _process(delta):
	if player != null:
		points[0] = player.global_position
		points[1] = target
	else:
		#player = get_node("/../Player")
		pass

func make_line(target_pos, player_inst):
	if player == null:
		player = player_inst
	target = target_pos
	visible = true

func hide_line():
	visible = false
