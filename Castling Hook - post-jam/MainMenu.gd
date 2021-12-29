extends Control


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

# Called when the node enters the scene tree for the first time.
func _ready():
	Prefs.load_settings()
	
	$Crown.visible = Prefs.get_setting("progress", "complete")
	$Settings/MarginContainer/HBoxContainer/VBoxContainer/Fullscreen/MuteToggle.pressed = Prefs.get_setting("graphics", "fullscreen")
	$Settings/MarginContainer/HBoxContainer/VBoxContainer/MuteMusic/MuteToggle.pressed = Prefs.get_setting("volume", "mute_music")
	$Settings/MarginContainer/HBoxContainer/VBoxContainer/MuteSFX/MuteToggle.pressed = Prefs.get_setting("volume", "mute_sound")
	$Settings/MarginContainer/HBoxContainer/VBoxContainer/MusicVolume/HSlider.value = Prefs.get_setting("volume", "music_volume")
	$Settings/MarginContainer/HBoxContainer/VBoxContainer/SoundVolume/HSlider.value = Prefs.get_setting("volume", "sound_volume")
	
	Prefs.apply_settings()


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func settings_pressed():
	$Settings.visible = true

func exit_pressed():
	Prefs.save_settings()
	get_tree().quit()

func new_game():
	var dir = Directory.new()
	dir.remove("user://savegame.save")
	get_tree().change_scene("res://Game.tscn")

func continue_game():
	get_tree().change_scene("res://Game.tscn")
