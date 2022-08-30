extends Control


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var SettingsButton: PackedScene = load("res://Scenes/PauseMenuSettings.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	Saver.saveData()
	MusicAutoLoad.StopMusic()

# Called every frame. 'delta' is the elapsed time since the previous frame.

func _on_Resume_button_down():
	get_tree().paused = false
	
	MusicAutoLoad.Click()
	MusicAutoLoad.PlayMusic()
	queue_free()
	MusicAutoLoad.StopMusic()
	PointSystem.paused = false


func _on_Settings_button_down():
	
	add_child(SettingsButton.instance())
	


func _on_LeaveGame_button_down():
	
	MusicAutoLoad.StopMusic()
	MusicAutoLoad.StopInGameMusic()
	MusicAutoLoad.Click()
	get_tree().paused = false
	get_tree().change_scene("res://Scenes/Main Menu.tscn")
	PointSystem.paused = false
