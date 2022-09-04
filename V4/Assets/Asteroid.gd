extends KinematicBody2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var collision

# Called when the node enters the scene tree for the first time.
func _ready():
	PointSystem.spawnDelay = 1000 - int(PointSystem.points / 100)


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func _physics_process(delta):
	move_and_slide(Vector2.DOWN * PointSystem.asteroidSpeed)
		
	
	if position.y > 800:
		queue_free()


func _on_Area2D_body_entered(body):
	PointSystem.points += 5
	print("killed by:", body)
	PointSystem.asteroidsDefeated += 1 
	queue_free()
