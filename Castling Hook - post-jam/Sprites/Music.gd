extends AudioStreamPlayer


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	update_music(Prefs.music_volume)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	update_music(Prefs.music_volume)

func update_music(new_volume):
	if Prefs.mute_music == true:
		volume_db = linear2db(0)
	else:
		volume_db = linear2db(new_volume / 100)
