extends Node


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var points = 0
var totalPoints = 0
var spawnDelay = 1000
var bestScore = 0
var asteroidsDefeated = 0
var bossIsOnTheScene = false
var asteroidSpeed = 300
var asteroidIncrementer = 1
var paused = false

var golden_asteroids = 0
var temp_golden_asteroids = 0

var rockets = {
	"Bullet": false,
	"Lucky": false,
	"Time": false,
	"US_military": false,
	"Lucky_military": false
}

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if (points - 300) / asteroidIncrementer >= 100:
		asteroidSpeed += 100
		asteroidIncrementer += 1
		#print(asteroidIncrementer)
func resetSpeed():
	asteroidSpeed = 300
	asteroidIncrementer = 1
	print("reset")
