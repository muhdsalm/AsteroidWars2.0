extends Node


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var menu_music = load("res://res/sound/menu music/game.menu.music.2.ogg")
var menu_music_playing = false
var music_volume = 0
var sound = true

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	print(sound)
	$MenuMusic.volume_db = music_volume
	if music_volume == -35:
		$MenuMusic.volume_db = -100
	print($MenuMusic.volume_db)

func StartMusic():
	$MenuMusic.stream = menu_music
	$MenuMusic.play()
	menu_music_playing = true
func StopMusic():
	$MenuMusic.stop()
	menu_music_playing = false
func keep_music_looping():
	if $MenuMusic.playing == false:
		$MenuMusic.play()
		
func Click():
	if sound:
		$Click.play()
