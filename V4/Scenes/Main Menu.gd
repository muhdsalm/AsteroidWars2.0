extends Control


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	
	if !(MusicAutoLoad.menu_music_playing):
		MusicAutoLoad.StartMusic()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	MusicAutoLoad.keep_music_looping()



func _on_PlayButton_pressed():
	get_tree().change_scene("res://Scenes/Man Scene.tscn")


func _on_HelpButton_pressed():
	get_tree().change_scene("res://Scenes/Help_Controls.tscn")


func _on_QuitButton_pressed():
	get_tree().quit(0)


func _on_MyStationButton_button_down():
	get_tree().change_scene("res://Scenes/MyStation.tscn")
