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

var MusicIsRunning = false


# Called when the node enters the scene tree for the first time.
func _ready():
	for i in range(10):
		backgrounds.append([])
		for j in range(10):
			backgrounds[i].append(load("res://Assets/Space.tscn"))
			backgrounds[i][j] = backgrounds[i][j].instance()
			add_child(backgrounds[i][j])
			backgrounds[i][j].position = Vector2(i * 80, (j - 1) * 80)
	
	MusicAutoLoad.StopMusic()
	
	if !MusicIsRunning:
		$JukeBox.stream = in_game_music_before_jupiter_dies
		$JukeBox.play()
		MusicIsRunning = true
	rng.randomize()
	randomPosition = rng.randi_range(0, 700)
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	
	$JukeBox.volume_db = MusicAutoLoad.music_volume
		
	if OS.get_ticks_msec() - then > delay:
		
		$AsteroidSpawner.position.x = randomPosition
		
		Asteroids.append(Asteroid)
		Asteroids[Asteroids.size() - 1] = Asteroids[Asteroids.size() - 1].instance()
		add_child(Asteroids[Asteroids.size() - 1])
		Asteroids[Asteroids.size() - 1].position.x  = $AsteroidSpawner.position.x
		Asteroids[Asteroids.size() - 1].position.y = $AsteroidSpawner.position.y
		
		delay = rng.randi_range(1, PointSystem.spawnDelay)
		then = OS.get_ticks_msec()
		randomPosition = rng.randi_range(0, 700)
		
	$Score.text = String(PointSystem.points)
	
	if OS.get_unix_time()-ScorePrevTime >= 1:
		PointSystem.points+=1
		ScorePrevTime = OS.get_unix_time()
		
		if spam < 15:
			spam += 1
		
		if spam <= 5:
			$Node2D/SpamBar.color = Color(1, 0, 0, 1)
		
		if spam > 5 and spam <= 10:
			$Node2D/SpamBar.color = Color(1, 1, 0, 1)
		if spam > 10:
			$Node2D/SpamBar.color = Color(0, 1, 0, 1)
			
	$Node2D/SpamBar.rect_size.x = spam * 7
	
	if spam <= 0:
		get_tree().change_scene("res://Scenes/GameOver.tscn")
	
func _input(event):
	
	if event.is_action_pressed("Fire"):
		
		Bullets.append(Bullet)
		Bullets[Bullets.size() - 1] = Bullets[Bullets.size() - 1].instance()
		add_child(Bullets[Bullets.size() - 1])
		Bullets[Bullets.size() - 1].position = $DefaultRocket.position
		
		spam -= 1
		
	if event.is_action_pressed("Pause"):
		
		get_tree().paused = true
		add_child(PauseMenu.instance())
		