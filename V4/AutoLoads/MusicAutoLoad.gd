extends Node


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var menu_music = load("res://res/sound/menu music/game.menu.music.2.ogg")
var menu_music_playing = false
var music_volume = 0
var sound = true

var in_game_music_before_jupiter_dies = load("res://res/sound/in-game.music.before-jupiter-boss-fight.ogg")
var MusicIsRunning = false

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	$MenuMusic.volume_db = music_volume
	$JukeBox.volume_db = MusicAutoLoad.music_volume
	if music_volume == -35:
		$MenuMusic.volume_db = -100
	

func StartMusic():
	$MenuMusic.stream = menu_music
	$MenuMusic.play()
	menu_music_playing = true
func StopMusic():
	$MenuMusic.stop()
	$JukeBox.pause_mode =Node.PAUSE_MODE_STOP
func PlayMusic():
	$JukeBox.pause_mode = Node.PAUSE_MODE_PROCESS
	menu_music_playing = false
func keep_music_looping():
	if $MenuMusic.playing == false:
		$MenuMusic.play()
		
func Click():
	if sound:
		$Click.play()
func StartInGameMusic():
	MusicIsRunning = false
	$JukeBox.stop()
	if !MusicIsRunning:
		$JukeBox.stream = in_game_music_before_jupiter_dies
		$JukeBox.play()
		MusicIsRunning = true
func StartAfterJupiterMusic():
	$JukeBox.stop()
	$JukeBox.stream = load("res://res/sound/AFTER boss fight music/in-game.boss-fight.after-jupiter.music.mp3")
	$JukeBox.play()
