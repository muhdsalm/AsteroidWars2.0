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
	pass



func _on_PlayButton_pressed():
	MusicAutoLoad.Click()
	get_tree().change_scene("res://Scenes/Man Scene.tscn")


func _on_HelpButton_pressed():
	MusicAutoLoad.Click()
	
	
	get_tree().change_scene("res://Scenes/Help_Controls.tscn")


func _on_QuitButton_pressed():
	MusicAutoLoad.Click()
	get_tree().quit(0)


func _on_MyStationButton_button_down():
	MusicAutoLoad.Click()
	get_tree().change_scene("res://Scenes/MyStation.tscn")
