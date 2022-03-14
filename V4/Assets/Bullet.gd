extends KinematicBody2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var collision
var speed = 500


# Called when the node enters the scene tree for the first time.
func _ready():
	
	if MusicAutoLoad.sound:
		$AudioStreamPlayer.play()


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func _physics_process(delta):
	
	move_and_slide(Vector2.UP * speed)
	
	if position.y < 0:
		queue_free()
