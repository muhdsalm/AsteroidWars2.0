extends KinematicBody2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if $KinematicBody2D.shields == 2:
		$Sprite.visible = true
		$Sprite2.visible = true
	if $KinematicBody2D.shields == 1:
		$Sprite.visible = true
		$Sprite2.visible = false
	if $KinematicBody2D.shields == 0:
		$Sprite.visible = false
		$Sprite2.visible = false
	$
