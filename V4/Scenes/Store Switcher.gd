extends Control


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Button_button_down():
	MusicAutoLoad.Click()
	get_tree().change_scene("res://Scenes/Rocket Page Store.tscn")


func _on_Button2_button_down():
	MusicAutoLoad.Click()
	get_tree().change_scene("res://Scenes/Upgrades Page Store.tscn")


func _on_Button3_button_down():
	MusicAutoLoad.Click()
	get_tree().change_scene("res://Scenes/Power-ups Page Store.tscn")


func _on_Button4_button_down():
	MusicAutoLoad.Click()
	get_tree().change_scene("res://Scenes/Main Menu.tscn")
