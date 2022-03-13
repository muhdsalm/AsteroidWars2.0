extends Sprite


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var rng = RandomNumberGenerator.new()


# Called when the node enters the scene tree for the first time.
func _ready():
	rng.randomize()
	texture = load("res://res/in game background/space" + rng.randi_range(1, 4) as String + ".png")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	
	position.y += 1;
	
	if position.y > 700:
		position.y = -80
	
		
