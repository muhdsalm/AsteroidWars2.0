extends Control


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var tempCurrentScore = 0
var tempCurrentBestScore = 0
var tempCurrentAsteroidsDefeated = 0
var pointsleft = 0
var justUseGlobalScore = false


# Called when the node enters the scene tree for the first time.
func _ready():
	MusicAutoLoad.StopInGameMusic()
	
	if MusicAutoLoad.sound:
		$CrashSound.play()
	
	MusicAutoLoad.StopMusic()
	
	if PointSystem.points > PointSystem.bestScore:
		PointSystem.bestScore = PointSystem.points
	
	PointSystem.totalPoints = PointSystem.points
	print(PointSystem.points)
	print(PointSystem.bestScore)
	print(PointSystem.asteroidsDefeated)
	pointsleft = PointSystem.points
	Saver.saveData()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	$Score.text = String(tempCurrentScore)
	$BestScore.text = String(tempCurrentBestScore)
	$AsteroidsDefeated.text = String(tempCurrentAsteroidsDefeated)
	
	if justUseGlobalScore:
		$Score.text = String(PointSystem.points)
		$BestScore.text = String(PointSystem.bestScore)
		$AsteroidsDefeated.text = String(PointSystem.asteroidsDefeated)
	
	if pointsleft < 100:
		pointsleft-=1
		if tempCurrentScore < PointSystem.points:
			tempCurrentScore += 1
		elif tempCurrentBestScore < PointSystem.bestScore:
			tempCurrentBestScore += 1
		elif tempCurrentAsteroidsDefeated < PointSystem.asteroidsDefeated:
			tempCurrentAsteroidsDefeated += 1
	elif pointsleft < 200:
		pointsleft-=2
		if tempCurrentScore < PointSystem.points:
			tempCurrentScore += 2
		elif tempCurrentBestScore < PointSystem.bestScore:
			tempCurrentBestScore += 2
		elif tempCurrentAsteroidsDefeated < PointSystem.asteroidsDefeated:
			tempCurrentAsteroidsDefeated += 1
	if pointsleft < 500:
		pointsleft-=5
		if tempCurrentScore < PointSystem.points:
			tempCurrentScore += 5
		elif tempCurrentBestScore < PointSystem.bestScore:
			tempCurrentBestScore += 5
		elif tempCurrentAsteroidsDefeated < PointSystem.asteroidsDefeated:
			tempCurrentAsteroidsDefeated += 1
	elif pointsleft < 1000:
		pointsleft-=10
		if tempCurrentScore < PointSystem.points:
			tempCurrentScore += 10
		elif tempCurrentBestScore < PointSystem.bestScore:
			tempCurrentBestScore += 10
		elif tempCurrentAsteroidsDefeated < PointSystem.asteroidsDefeated:
			tempCurrentAsteroidsDefeated += 1
	elif pointsleft < 5000:
		pointsleft-=100
		if tempCurrentScore < PointSystem.points:
			tempCurrentScore += 100
		elif tempCurrentBestScore < PointSystem.bestScore:
			tempCurrentBestScore += 100
		elif tempCurrentAsteroidsDefeated < PointSystem.asteroidsDefeated:
			tempCurrentAsteroidsDefeated += 1
	else:
		pointsleft-=1000
		if tempCurrentScore < PointSystem.points:
			tempCurrentScore += 1000
		elif tempCurrentBestScore < PointSystem.bestScore:
			tempCurrentBestScore += 1000
		elif tempCurrentAsteroidsDefeated < PointSystem.asteroidsDefeated:
			tempCurrentAsteroidsDefeated += 1

	if pointsleft <= 0:
		pointsleft = PointSystem.bestScore
		justUseGlobalScore = true


func _on_Button_button_down():
	
	MusicAutoLoad.Click()
	
	PointSystem.points = 0
	PointSystem.asteroidsDefeated = 0
	PointSystem.spawnDelay = 1000
	PointSystem.resetSpeed()
	get_tree().change_scene("res://Scenes/Man Scene.tscn")
	
func _input(event):
	
	if Input.is_key_pressed(KEY_R):
		PointSystem.points = 0
		PointSystem.asteroidsDefeated = 0
		PointSystem.spawnDelay = 1000
		PointSystem.resetSpeed()
		get_tree().change_scene("res://Scenes/Man Scene.tscn")
