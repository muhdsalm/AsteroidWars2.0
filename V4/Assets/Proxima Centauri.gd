extends KinematicBody2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var life = 40
var isdead = false


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	move_and_slide(Vector2.DOWN * 10)
	$LifeBar.position.y -= 0.15
	if life == 20:
		$LifeBar.texture = load("res://res/bosses/boss health bars/jupiter/jupiter.health.100%.png")
	elif life > 17:
		$LifeBar.texture = load("res://res/bosses/boss health bars/jupiter/jupiter.health.85%.png")
	elif life > 15:
		$LifeBar.texture = load("res://res/bosses/boss health bars/jupiter/jupiter.health.75%.png")
	elif life > 12:
		$LifeBar.texture = load("res://res/bosses/boss health bars/jupiter/jupiter.health.60%.png")
	elif life > 10:
		$LifeBar.texture = load("res://res/bosses/boss health bars/jupiter/jupiter.health.50%.png")
	elif life > 6:
		$LifeBar.texture = load("res://res/bosses/boss health bars/jupiter/jupiter.health.30%.png")
	elif life > 5:
		$LifeBar.texture = load("res://res/bosses/boss health bars/jupiter/jupiter.health.25%.png")
	elif life > 2:
		$LifeBar.texture = load("res://res/bosses/boss health bars/jupiter/jupiter.health.10%.png")
	elif life < 2:
		$LifeBar.texture = load("res://res/bosses/boss health bars/jupiter/jupiter.health.0%.png")


	if life <= 0 and !isdead:
		print("me dead xD")
		isdead = true
		MusicAutoLoad.StartAfterProximaCentauriMusic()
		$Area2D.queue_free()
		$Sprite.queue_free()
		$CollisionShape2D.queue_free()
		$Timer.start()



func _on_Area2D_body_entered(body):
	life -= 1
	PointSystem.points += 15



func _on_Timer_timeout():
	PointSystem.bossIsOnTheScene = false
	queue_free()
