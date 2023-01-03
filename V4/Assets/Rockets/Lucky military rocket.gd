extends KinematicBody2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var Velocity = Vector2.ZERO
var speed = 500


# Called when the node enters the scene tree for the first time.
func _ready():
	PointSystem.GA_max_random_number = 8


# Called every frame. 'delta' is the elapsed time since the previous frame.
	
func _physics_process(delta):
	
	move_and_collide(Velocity * delta)
	
	if position.y < 43:
		position.y = 43
	if position.y > 656:
		position.y = 656
	if position.x < 18:
		position.x = 18
	if position.x > 702:
		position.x = 702
	

func _input(event):
	if event.is_action_pressed("Down"):
		Velocity.y = speed
	if event.is_action_pressed("Up"):
		Velocity.y = -speed
	if event.is_action_pressed("Right"):
		Velocity.x = speed
	if event.is_action_pressed("Left"):
		Velocity.x = -speed
		
	if event.is_action_released("Down"):
		Velocity.y = 0
	if event.is_action_released("Up"):
		Velocity.y = 0
	if event.is_action_released("Right"):
		Velocity.y = 0
	if event.is_action_released("Left"):
		Velocity.y = 0
	
func zeroOutTheVelocity():
	Velocity = Vector2.ZERO
		
	

	


func _on_Area2D_body_entered(body):
	
	if int(rand_range(0, 100)) <= 35:
		return
	PointSystem.GA_max_random_number = 10
	MusicAutoLoad.StopMusic()
	get_tree().change_scene("res://Scenes/GameOver.tscn")
	
