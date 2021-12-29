extends NinePatchRect


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	$MarginContainer/HBoxContainer/VBoxContainer/Fullscreen/MuteToggle.pressed = Prefs.get_setting("graphics", "fullscreen")
	$MarginContainer/HBoxContainer/VBoxContainer/MuteMusic/MuteToggle.pressed = Prefs.get_setting("volume", "mute_music")
	$MarginContainer/HBoxContainer/VBoxContainer/MuteSFX/MuteToggle.pressed = Prefs.get_setting("volume", "mute_sound")
	$MarginContainer/HBoxContainer/VBoxContainer/MusicVolume/HSlider.value = Prefs.get_setting("volume", "music_volume")
	$MarginContainer/HBoxContainer/VBoxContainer/SoundVolume/HSlider.value = Prefs.get_setting("volume", "sound_volume")

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func toggle_fullscreen(button_pressed):
	Prefs.fullscreen = button_pressed
	Prefs.set_setting("graphics", "fullscreen", Prefs.fullscreen)
	Prefs.apply_settings()

func toggle_mute_music(button_pressed):
	Prefs.mute_music = button_pressed
	Prefs.set_setting("volume", "mute_music", Prefs.mute_music)
	Prefs.save_settings()

func toggle_mute_sound(button_pressed):
	Prefs.mute_sound = button_pressed
	Prefs.set_setting("volume", "mute_sound", Prefs.mute_sound)
	Prefs.save_settings()

func music_volume_changed(value):
	Prefs.music_volume = value
	Prefs.set_setting("volume", "music_volume", Prefs.music_volume)
	Prefs.save_settings()

func sound_volume_changed(value):
	Prefs.sound_volume = value
	Prefs.set_setting("volume", "sound_volume", Prefs.sound_volume)
	Prefs.save_settings()

func close_settings():
	visible = false
	Prefs.save_settings()
