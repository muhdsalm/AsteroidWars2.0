extends Control


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	
	if Input.is_key_pressed(KEY_P):
		$Node2D.visible = false


func _on_Resume_button_down():
	get_tree().paused = false
	
	MusicAutoLoad.Click()
	queue_free()
	MusicAutoLoad.StopMusic()


func _on_Settings_button_down():
	
	MusicAutoLoad.Click()
	$Node2D.visible = true


func _on_LeaveGame_button_down():
	
	MusicAutoLoad.Click()
	get_tree().paused = false
	get_tree().change_scene("res://Scenes/Main Menu.tscn")
