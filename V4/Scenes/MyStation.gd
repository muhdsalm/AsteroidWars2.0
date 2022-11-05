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
func _process(delta):
	$Sprite.set_modulate(Color(0, 1, 1, 1))
	$Sprite2.set_modulate(Color(0, 1, 1, 1))
	$Sprite3.set_modulate(Color(0, 1, 1, 1))
	$Sprite4.set_modulate(Color(0, 1, 1, 1))
	$Sprite5.set_modulate(Color(0, 1, 1, 1))
	$Sprite6.set_modulate(Color(0, 1, 1, 1))
	
	if PointSystem.selected_rockets == PointSystem.Rockets.Default:
		$Sprite.set_modulate(Color(1, 1, 1, 1))
	if PointSystem.selected_rockets == PointSystem.Rockets.Bullet:
		$Sprite2.set_modulate(Color(1, 1, 1, 1))
	if PointSystem.selected_rockets == PointSystem.Rockets.Lucky:
		$Sprite3.set_modulate(Color(1, 1, 1, 1))
	if PointSystem.selected_rockets == PointSystem.Rockets.Time:
		$Sprite4.set_modulate(Color(1, 1, 1, 1))
	if PointSystem.selected_rockets == PointSystem.Rockets.US_Military:
		$Sprite5.set_modulate(Color(1, 1, 1, 1))
	if PointSystem.selected_rockets == PointSystem.Rockets.Lucky_military:
		$Sprite6.set_modulate(Color(1, 1, 1, 1))



func _on_Default_button_down():
	PointSystem.GA_max_random_number = 10
	PointSystem.selected_rockets = PointSystem.Rockets.Default
	Saver.saveData()


func _on_Bullet_button_down():
	PointSystem.GA_max_random_number = 10
	if PointSystem.rockets["Bullet"] == false:
		return
	PointSystem.selected_rockets = PointSystem.Rockets.Bullet
	Saver.saveData()

func _on_Lucky_button_down():
	PointSystem.GA_max_random_number = 9
	if PointSystem.rockets["Lucky"] == false:
		return
	PointSystem.selected_rockets = PointSystem.Rockets.Lucky
	Saver.saveData()

func _on_Time_button_down():
	PointSystem.GA_max_random_number = 10
	if PointSystem.rockets["Time"] == false:
		return
	PointSystem.selected_rockets = PointSystem.Rockets.Time
	Saver.saveData()

func _on_US_mil_button_down():
	PointSystem.GA_max_random_number = 10
	if PointSystem.rockets["US_military"] == false:
		return
	PointSystem.selected_rockets = PointSystem.Rockets.US_Military
	Saver.saveData()

func _on_Luck_mil_button_down():
	PointSystem.GA_max_random_number = 8
	if PointSystem.rockets["Lucky_military"] == false:
		return
	PointSystem.selected_rockets = PointSystem.Rockets.Lucky_military
	Saver.saveData()


func _on_Button_button_down():
	get_tree().change_scene("res://Scenes/Main Menu.tscn")
