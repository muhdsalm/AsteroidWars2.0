extends Control


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var FPSShown = false


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	$Node2D/FPS.text = "FPS: " + String(Engine.get_frames_per_second())
	
	if FPSShown:
		$Node2D/FPS.visible = true
	elif !FPSShown:
		$Node2D/FPS.visible = false
