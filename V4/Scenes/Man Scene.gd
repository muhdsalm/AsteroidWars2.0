extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var backgrounds = []
var in_game_music_before_jupiter_dies = load("res://res/sound/in-game.music.before-jupiter-boss-fight.ogg")
var rng = RandomNumberGenerator.new()

var delay = rng.randi_range(1, PointSystem.spawnDelay)
var Asteroid: PackedScene = load("res://Assets/Asteroid.tscn")
var Asteroids = []
var then = OS.get_ticks_msec()
var randomPosition = rng.randi_range(0, 700)

var Bullet: PackedScene = load("res://Assets/Bullet.tscn")
var Bullets = []

var ScorePrevTime = OS.get_unix_time()

var PauseMenu = load("res://Scenes/Pause.tscn")

var spam = 15

var Jupiter = load("res://Assets/Jupiter.tscn")
var bosshasspawned = false

var unfocuspause = false

var Bullet_rocket = preload("res://Assets/Rockets/Bullet Rocket.tscn").instance(PackedScene.GEN_EDIT_STATE_MAIN)
var Lucky_rocket = preload("res://Assets/Rockets/Lucky Rocket.tscn").instance(PackedScene.GEN_EDIT_STATE_MAIN)
var Time_rocket = preload("res://Assets/Rockets/Time Rocket.tscn").instance(PackedScene.GEN_EDIT_STATE_MAIN)
var US_mil_rocket = preload("res://Assets/Rockets/US military rocket.tscn").instance(PackedScene.GEN_EDIT_STATE_MAIN)
var Lucky_mil_rocket = preload("res://Assets/Rockets/Lucky military rocket.tscn").instance(PackedScene.GEN_EDIT_STATE_MAIN)

onready var current_rocket = $DefaultRocket

# Called when the node enters the scene tree for the first time.
func _ready():
	current_rocket = $DefaultRocket
	
	if PointSystem.selected_rockets == PointSystem.Rockets.Bullet:
		$DefaultRocket.queue_free()
		current_rocket = Bullet_rocket
		add_child(current_rocket)
		current_rocket.position = $DefaultRocket.position
	if PointSystem.selected_rockets == PointSystem.Rockets.Lucky:
		$DefaultRocket.queue_free()
		current_rocket = Lucky_rocket
		add_child(current_rocket)
		Lucky_rocket.position = $DefaultRocket.position
	if PointSystem.selected_rockets == PointSystem.Rockets.Time:
		$DefaultRocket.queue_free()
		current_rocket = Time_rocket
		add_child(current_rocket)
		Time_rocket.position = $DefaultRocket.position
	if PointSystem.selected_rockets == PointSystem.Rockets.Lucky_military:
		$DefaultRocket.queue_free()
		current_rocket = Lucky_mil_rocket
		add_child(current_rocket)
		Lucky_mil_rocket.position = $DefaultRocket.position
	if PointSystem.selected_rockets == PointSystem.Rockets.US_Military:
		$DefaultRocket.queue_free()
		current_rocket = US_mil_rocket
		add_child(current_rocket)
		US_mil_rocket.position = $DefaultRocket.position
	
	MusicAutoLoad.StopMusic()
	MusicAutoLoad.PlayMusic()
	$Node2D/Score.add_color_override("font_color", Color(1,1,0,1))
	for i in range(10):
		backgrounds.append([])
		for j in range(10):
			backgrounds[i].append(load("res://Assets/Space.tscn"))
			backgrounds[i][j] = backgrounds[i][j].instance()
			add_child(backgrounds[i][j])
			backgrounds[i][j].position = Vector2(i * 80, (j - 1) * 80)
	
	MusicAutoLoad.StartInGameMusic()
	rng.randomize()
	randomPosition = rng.randi_range(0, 700)
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	
	if PointSystem.points > 1000 and !bosshasspawned:
		PointSystem.bossIsOnTheScene = true
		add_child(Jupiter.instance())
		bosshasspawned = true
		
		
		
	if !PointSystem.bossIsOnTheScene:
		if OS.get_ticks_msec() - then > delay:
			
			randomPosition = rng.randi_range(0, 700)
			$AsteroidSpawner.position.x = randomPosition
			
			"""Asteroids.append(Asteroid)
			Asteroids[Asteroids.size() - 1] = Asteroids[Asteroids.size() - 1].instance()
			add_child(Asteroids[Asteroids.size() - 1])
			Asteroids[Asteroids.size() - 1].position.x  = $AsteroidSpawner.position.x
			Asteroids[Asteroids.size() - 1].position.y = $AsteroidSpawner.position.y"""
			var asteroid = Asteroid.instance()
			asteroid.position = $AsteroidSpawner.position
			add_child(asteroid)
			
			delay = rng.randi_range(1, PointSystem.spawnDelay)
			then = OS.get_ticks_msec()
		
	$Node2D/Score.text = String(PointSystem.points)
	
	if OS.get_unix_time()-ScorePrevTime >= 1:
		PointSystem.points+=1
		ScorePrevTime = OS.get_unix_time()
		
		if spam < 15:
			spam += 1
		
		if spam <= 5:
			$Node2D/SpamBar.color = Color(1, 0, 0, 1)
			if MusicAutoLoad.sound:
				$"Overheat Warn".play()
			$Node2D/SpamBarFrame.texture = load("res://res/icons/Cooldown Bar/cooldown.bar.overheat.png")
		if spam > 5 and spam <= 10:
			$Node2D/SpamBar.color = Color(1, 1, 0, 1)
			$Node2D/SpamBarFrame.texture = load("res://res/icons/Cooldown Bar/cooldown.bar.hot.png")
		if spam > 10:
			$Node2D/SpamBar.color = Color(0, 1, 0, 1)
			$Node2D/SpamBarFrame.texture = load("res://res/icons/Cooldown Bar/cooldown.bar.cool.png")
			
	$Node2D/SpamBar.rect_size.x = spam * 7
	
	if spam <= 0:
		get_tree().change_scene("res://Scenes/GameOver.tscn")
		
	if PointSystem.paused:
		
		current_rocket.zeroOutTheVelocity()
		add_child(PauseMenu.instance())
		print("nice")
		MusicAutoLoad.StopMusic()
		print("even nicer lol")
		get_tree().paused = true
		
		
	
func _input(event):
	
	
	if event.is_action_pressed("Fire"):
		
		Bullets.append(Bullet)
		Bullets[Bullets.size() - 1] = Bullets[Bullets.size() - 1].instance()
		add_child(Bullets[Bullets.size() - 1])
		Bullets[Bullets.size() - 1].position = current_rocket.position
		
		spam -= 1
		
	if event.is_action_pressed("Pause"):
		PointSystem.paused = true


func _on_Timer_timeout():
	get_tree().paused = true
		
func _notification(what):
	if what == NOTIFICATION_WM_FOCUS_OUT:
			PointSystem.paused = true
