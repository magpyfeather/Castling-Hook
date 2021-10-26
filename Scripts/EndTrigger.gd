extends Area2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func player_touched(body):
	if body.name == "Player":
		body.visible = false
		body.active = false
		body.reset_hook()
		body.set_deferred("mode", 1)
		$Polygon2D.visible = false
		$AnimatedSprite.visible = true
		$AnimatedSprite.play("finish")


func animation_finished():
	$Label.visible = true
	$AnimatedSprite.play("loop")
