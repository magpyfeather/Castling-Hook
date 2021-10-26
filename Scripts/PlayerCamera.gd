extends Camera2D

var interpolate_val = 2
var camera_strength = 800

func _physics_process(delta):
	var target = get_node("../Player").global_position 
	
	# Moves the camera up or down. Based on Jump King.
	var active_strength = (Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")) * camera_strength
	var true_position = target.y + active_strength
	
	
	
	global_position = Vector2(0,true_position)
