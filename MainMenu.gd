extends Control


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func toggle_fullscreen(button_pressed):
	Prefs.fullscreen = button_pressed
	Prefs.apply_settings()

func toggle_mute_music(button_pressed):
	Prefs.mute_music = button_pressed

func toggle_mute_sound(button_pressed):
	Prefs.mute_sound = button_pressed

func music_volume_changed(value):
	Prefs.music_volume = value - 100

func sound_volume_changed(value):
	Prefs.sound_volume = value - 100

func play_pressed():
	get_tree().change_scene("res://Game.tscn")

func settings_pressed():
	$Settings.visible = true

func exit_pressed():
	get_tree().quit()

func close_settings():
	$Settings.visible = false
