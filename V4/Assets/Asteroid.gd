extends KinematicBody2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var collision
var speed = 300

# Called when the node enters the scene tree for the first time.
func _ready():
	
	speed += int(PointSystem.points / 100) * 100
	PointSystem.spawnDelay = 1000 - int(PointSystem.points / 100)


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func _physics_process(delta):
	move_and_slide(Vector2.DOWN * speed)
		
	
	if position.y > 700:
		queue_free()


func _on_Area2D_body_entered(body):
	PointSystem.points += 5
	
	PointSystem.asteroidsDefeated += 1 
	queue_free()
