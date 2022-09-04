extends KinematicBody2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var Velocity = Vector2.ZERO
var speed = 500
export var shields = 2


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	$Sprite.global_position = Vector2(589, 636)
	$Sprite2.global_position = Vector2(658, 636)
	
	if shields == 2:
		$Sprite.visible = true
		$Sprite2.visible = true
	if shields == 1:
		$Sprite.visible = true
		$Sprite2.visible = false
	if shields == 0:
		$Sprite.visible = false
		$Sprite2.visible = false
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
		Velocity += Vector2.DOWN * speed
	if event.is_action_pressed("Up"):
		Velocity += Vector2.UP * speed
	if event.is_action_pressed("Right"):
		Velocity += Vector2.RIGHT * speed
	if event.is_action_pressed("Left"):
		Velocity += Vector2.LEFT * speed
		
	if event.is_action_released("Down"):
		Velocity -= Vector2.DOWN * speed
	if event.is_action_released("Up"):
		Velocity -= Vector2.UP * speed
	if event.is_action_released("Right"):
		Velocity -= Vector2.RIGHT * speed
	if event.is_action_released("Left"):
		Velocity -= Vector2.LEFT * speed
	
func zeroOutTheVelocity():
	Velocity = Vector2.ZERO
		
	

	


func _on_Area2D_body_entered(body):
	
	shields -= 1
	if shields == -1:
		MusicAutoLoad.StopMusic()
		get_tree().change_scene("res://Scenes/GameOver.tscn")
	
