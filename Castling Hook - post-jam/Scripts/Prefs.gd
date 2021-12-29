extends Node

#Code for ConfigFile saving is taken from GDQuest Godot Demos, which are distributed under the MIT License.
#
#MIT License
#
#Copyright (c) 2017 Nathan Lovato
#
#Permission is hereby granted, free of charge, to any person obtaining a copy
#of this software and associated documentation files (the "Software"), to deal
#in the Software without restriction, including without limitation the rights
#to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
#copies of the Software, and to permit persons to whom the Software is
#furnished to do so, subject to the following conditions:
#
#The above copyright notice and this permission notice shall be included in all
#copies or substantial portions of the Software.
#
#THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
#IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
#FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
#AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
#LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
#OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
#SOFTWARE.

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

# Constants, codes to check and see if loading was successful or not
enum {LOAD_SUCCESS, LOAD_ERROR_COULDNT_OPEN}

const SAVE_PATH = "user://settings.cfg"

var config = ConfigFile.new()

var sound_volume : int
var music_volume : int

var fullscreen : bool
var mute_sound : bool
var mute_music : bool

var complete : bool = false

var settings = {
	"graphics": {
		"fullscreen": fullscreen
	},
	"volume": {
		"sound_volume": sound_volume,
		"music_volume": music_volume,
		"mute_sound": mute_sound,
		"mute_music": mute_music
	},
	"progress": {
		"complete": complete
	}
}

# Called when the node enters the scene tree for the first time.
func _ready():
	pass

func apply_settings():
	OS.window_fullscreen = fullscreen

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func save_settings():
	for section in settings.keys():
		for key in settings[section].keys():
			# The ConfigFile object (_config_file is a ConfigFile) has all the methods you need to load, save, set and read values
			config.set_value(section, key, settings[section][key])
			var val = config.get_value(section,key)
			settings[section][key] = val
			# Printing the values for debug purposes
			print("%s: %s" % [key, val])
	
#	print(fullscreen)
#	print(sound_volume)
#	print(music_volume)
#	print(mute_music)
#	print(mute_sound)
	config.save(SAVE_PATH)

func load_settings():
	# If the file doesn't open correctly (doesn't exist or used by another process),
	# We can't load any data so we return outside the function
	# NB: You could check if the file exist with the File object (see example 13-Save)
	var error = config.load(SAVE_PATH)
	if error != OK:
		print("Error loading the settings. Error code: %s" % error)
		return LOAD_ERROR_COULDNT_OPEN

	for section in settings.keys():
		for key in settings[section].keys():
			# We store the settings in the dictionary. In this demo, it's up to the other nodes to retrieve the settings,
			# with get_setting and set_setting below.
			# Example 13-Save offers a slightly better, object oriented solution to build upon this example 
			# (delegating save and load to the other nodes, the Save.gd script being only responsible to save and load on/from the disk)
			var val = config.get_value(section,key,0)
			settings[section][key] = val
			# Printing the values for debug purposes
			print("%s: %s" % [key, val])
	return LOAD_SUCCESS

func get_setting(category, key):
	return settings[category][key]

func set_setting(category, key, value):
	settings[category][key] = value
