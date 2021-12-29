extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	Save.load_game()

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func _input(event):
	if event.is_action_pressed("pause"):
		if get_tree().paused == false:
			get_tree().paused = true
			$PauseScreen/PauseMenu.visible = true
		else:
			get_tree().paused = false
			$PauseScreen/PauseMenu.visible = false

func resume_pressed():
	$PauseScreen/PauseMenu.visible = false
	get_tree().paused = false

func settings_pressed():
	$PauseScreen/Settings.visible = true

func main_menu_pressed():
	Save.save_game()
	get_tree().paused = false
	get_tree().change_scene("res://MainMenu.tscn")
