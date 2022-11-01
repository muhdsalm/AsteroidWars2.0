extends KinematicBody2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var collision
var golden_asteroid = false

# Called when the node enters the scene tree for the first time.
func _ready():
	PointSystem.spawnDelay = 1000 - int(PointSystem.points / 100)
	if int(rand_range(0, 10)) == 1:
		golden_asteroid = true
		$Sprite.texture = load("res://res/Asteroids/golden_asteroid.png")
		print("SHINY!!!")


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func _physics_process(delta):
	move_and_slide(Vector2.DOWN * PointSystem.asteroidSpeed/2)
		
	
	if position.y > 800:
		queue_free()


func _on_Area2D_body_entered(body):
	if golden_asteroid:
		PointSystem.temp_golden_asteroids += int(rand_range(5, 10))
	PointSystem.points += 5
	print("killed by:", body)
	PointSystem.asteroidsDefeated += 1 
	queue_free()
