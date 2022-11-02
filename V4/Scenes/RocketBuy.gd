extends Sprite


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if PointSystem.rockets["Bullet"]:
		$Button.text = "BOUGHT"
		$Button.disabled = true
		#print("I AM HAVING THIS")


func _on_Button_button_down():
	if PointSystem.golden_asteroids > 250:
		if !PointSystem.rockets["Bullet"]:
			PointSystem.golden_asteroids -= 250
			PointSystem.rockets["Bullet"] = true
			Saver.saveData()
	


func _on_Button2_button_down():
	if PointSystem.golden_asteroids > 750:
		if !PointSystem.rockets["Lucky"]:
			PointSystem.golden_asteroids -= 750
			PointSystem.rockets["Lucky"] = true
			Saver.saveData()


func _on_Button3_button_down():
	if PointSystem.golden_asteroids > 1000:
		if !PointSystem.rockets["Time"]:
			PointSystem.golden_asteroids -= 1000
			PointSystem.rockets["Time"] = true
			Saver.saveData()


func _on_Button4_button_down():
	if PointSystem.golden_asteroids > 1250:
		if !PointSystem.rockets["US_military"]:
			PointSystem.golden_asteroids -= 1250
			PointSystem.rockets["US_military"] = true
			Saver.saveData()


func _on_Button5_button_down():
	if PointSystem.golden_asteroids > 2500:
		if !PointSystem.rockets["Lucky_military"]:
			PointSystem.golden_asteroids -= 2500
			PointSystem.rockets["Lucky_military"] = true
			Saver.saveData()
