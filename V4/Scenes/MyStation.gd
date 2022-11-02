extends Control


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	if !PointSystem.rockets["Bullet"]:
		$Sprite2.set_modulate(Color(1, 1, 1, 0.5))
	if !PointSystem.rockets["Lucky"]:
		$Sprite3.set_modulate(Color(1, 1, 1, 0.5))
	if !PointSystem.rockets["Time"]:
		$Sprite4.set_modulate(Color(1, 1, 1, 0.5))
	if !PointSystem.rockets["US_military"]:
		$Sprite5.set_modulate(Color(1, 1, 1, 0.5))
	if !PointSystem.rockets["Lucky_military"]:
		$Sprite6.set_modulate(Color(1, 1, 1, 0.5))

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Button_button_down():
	MusicAutoLoad.Click()
	get_tree().change_scene("res://Scenes/Main Menu.tscn")
