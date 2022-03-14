extends Control


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var tempCurrentScore = 0
var tempCurrentBestScore = 0
var tempCurrentAsteroidsDefeated = 0


# Called when the node enters the scene tree for the first time.
func _ready():
	
	if MusicAutoLoad.sound:
		$CrashSound.play()
	
	if PointSystem.points > PointSystem.bestScore:
		PointSystem.bestScore = PointSystem.points
	
	PointSystem.totalPoints = PointSystem.points
	print(PointSystem.points)
	print(PointSystem.bestScore)
	print(PointSystem.asteroidsDefeated)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	$Score.text = String(tempCurrentScore)
	$BestScore.text = String(tempCurrentBestScore)
	$AsteroidsDefeated.text = String(tempCurrentAsteroidsDefeated)
	
	if PointSystem.points < 100:
		if tempCurrentScore < PointSystem.points:
			tempCurrentScore += 1
		elif tempCurrentBestScore < PointSystem.bestScore:
			tempCurrentBestScore += 1
		elif tempCurrentAsteroidsDefeated < PointSystem.asteroidsDefeated:
			tempCurrentAsteroidsDefeated += 1
	elif PointSystem.points < 200:
		if tempCurrentScore < PointSystem.points:
			tempCurrentScore += 2
		elif tempCurrentBestScore < PointSystem.bestScore:
			tempCurrentBestScore += 2
		elif tempCurrentAsteroidsDefeated < PointSystem.asteroidsDefeated:
			tempCurrentAsteroidsDefeated += 2
	if PointSystem.points < 500:
		if tempCurrentScore < PointSystem.points:
			tempCurrentScore += 5
		elif tempCurrentBestScore < PointSystem.bestScore:
			tempCurrentBestScore += 5
		elif tempCurrentAsteroidsDefeated < PointSystem.asteroidsDefeated:
			tempCurrentAsteroidsDefeated += 5
	else:
		if tempCurrentScore < PointSystem.points:
			tempCurrentScore += 10
		elif tempCurrentBestScore < PointSystem.bestScore:
			tempCurrentBestScore += 10
		elif tempCurrentAsteroidsDefeated < PointSystem.asteroidsDefeated:
			tempCurrentAsteroidsDefeated += 10


func _on_Button_button_down():
	
	MusicAutoLoad.Click()
	
	PointSystem.points = 0
	PointSystem.asteroidsDefeated = 0
	PointSystem.spawnDelay = 1000
	get_tree().change_scene("res://Scenes/Man Scene.tscn")
	
func _input(event):
	
	if Input.is_key_pressed(KEY_R):
		PointSystem.points = 0
		PointSystem.asteroidsDefeated = 0
		PointSystem.spawnDelay = 1000
		get_tree().change_scene("res://Scenes/Man Scene.tscn")
