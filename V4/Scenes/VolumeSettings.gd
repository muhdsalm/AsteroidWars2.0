extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	$VolumeSlider.value = MusicAutoLoad.music_volume


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	MusicAutoLoad.music_volume = $VolumeSlider.value
	$MusicVolume.text = String(int( 100 - (($VolumeSlider.value / -1) / 0.35)))
