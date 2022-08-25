extends Control


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	MusicAutoLoad.keep_music_looping()


func _on_BackToMainPageButton_pressed():
	get_tree().paused = false
	MusicAutoLoad.Click()
	get_tree().change_scene("res://Scenes/Main Menu.tscn")


func _on_InfoButton_pressed():
	get_tree().paused = false
	MusicAutoLoad.Click()
	get_tree().change_scene("res://Scenes/Help_Info.tscn")


func _on_SettingsButton_pressed():
	get_tree().paused = false
	MusicAutoLoad.Click()
	get_tree().change_scene("res://Scenes/Help_Settings.tscn")


func _on_ControlsButton_button_down():
	get_tree().paused = false
	MusicAutoLoad.Click()
	
	get_tree().change_scene("res://Scenes/Help_Controls.tscn")
	
