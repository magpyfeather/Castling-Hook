extends Node


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var fullscreen = true
var mute_sound = false
var mute_music = false

var sound_volume = 1
var music_volume = 1

# Called when the node enters the scene tree for the first time.
func _ready():
	apply_settings()

func apply_settings():
	OS.window_fullscreen = fullscreen

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
