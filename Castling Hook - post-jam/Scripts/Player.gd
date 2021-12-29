extends RigidBody2D

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

# export (PackedScene) var grapple

var active = true
var grounded = false

var target = Vector2()

var grapple_ready = false
var grappling = false

signal make_line(target_pos, player_inst)
signal show_hook(target_pos, player_inst)
signal hide_line
signal hide_hook

# Called when the node enters the scene tree for the first time.
func _ready():
	#var new_grapple = grapple.instance()
	#get_tree().get_root().call_deferred("add_child", new_grapple)
	connect("make_line", get_parent().get_node("Grapple"), "make_line")
	connect("hide_line", get_parent().get_node("Grapple"), "hide_line")
	connect("show_hook", get_parent().get_node("Hook"), "show_hook")
	connect("hide_hook", get_parent().get_node("Hook"), "hide_hook")
	#connect("make_line", new_grapple, "make_line")
	#connect("hide_line", new_grapple, "hide_line")
	update_sound(Prefs.sound_volume)
	target = null

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func _physics_process(delta):
	$RayCast2D.look_at(get_global_mouse_position())
	$RayCast2D.force_raycast_update()
	
# When you click, launch the hook and consume your grapple charge.
# You get your grapple charge back when you land, indicated by the octagon around you.
	if active:
		if Input.is_action_pressed("click") and $RayCast2D.is_colliding() and grapple_ready == true and grappling == false:
			launch_hook()
			grapple_ready = false
			grappling = true
			$GrappleReady.visible = false
		if Input.is_action_just_released("click"):
			reset_hook()
			#grapple_ready = true
			grappling = false
		# A developer command for teleporting. Would be a shame if it were to fall into the wrong hands!
		#if Input.is_action_just_pressed("teleportize"):
		#	set_global_position(get_global_mouse_position())
	
# If you can hit something, indicator goes green.
# Otherwise, indicator is white.
	if $RayCast2D.is_colliding():
		$GrappleReady.modulate = Color(0,1,0)
	else:
		$GrappleReady.modulate = Color(1,1,1)
	
	if grappling == true and target != null:
		#$Hook.global_position = target
		var pull = (target - global_position).normalized()
		apply_central_impulse(pull * 20)

func launch_hook():
	#$Hook.visible = true
	target = $RayCast2D.get_collision_point()
	emit_signal("show_hook", target, self)
	emit_signal("make_line", target, self)

func reset_hook():
	target = null
	#$Hook.visible = false
	emit_signal("hide_hook")
	emit_signal("hide_line")

func update_sound(new_volume):
	if Prefs.mute_sound == true:
		$HitSound.volume_db = linear2db(0)
	else:
		$HitSound.volume_db = linear2db(new_volume / 100)

func hit_surface(body):
	if grounded == false:
		$HitSound.play()
	
	detect_collision()
	Save.save_game()

func detect_collision():
	# A really, really, really, really, really, really jank way of hit detection while letting the player roll.
	# And also for not making the hit sound play for the whole time the player is touching something.
	update_sound(Prefs.sound_volume)
	$RayCast2D2.look_at(position + Vector2(1, 0))
	$RayCast2D2.force_raycast_update()
	if $RayCast2D2.is_colliding():
		grounded = true
		if grapple_ready == false:
			grapple_ready = true
			$GrappleReady.visible = true
	else:
		grounded = false
		$HitSound.play()

func save():
	var save_dict = {
		"filename" : get_filename(),
		"parent" : get_parent().get_path(),
		"pos_x" : position.x, # Vector2 is not supported by JSON
		"pos_y" : position.y,
		"vel_x" : get_linear_velocity().x,
		"vel_y" : get_linear_velocity().y,
		"spin" : get_angular_velocity(),
		"grappling" : grappling,
		"grapple_ready" : grapple_ready
	}
	return save_dict
