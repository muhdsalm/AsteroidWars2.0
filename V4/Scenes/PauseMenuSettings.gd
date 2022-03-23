extends Control


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	$Node2D/MusicSlider.value = MusicAutoLoad.music_volume
	$Node2D/Sound.pressed = MusicAutoLoad.sound
	$Node2D/ShowFPS.pressed = PerformanceMonitor.FPSShown


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	MusicAutoLoad.music_volume = $Node2D/MusicSlider.value
	MusicAutoLoad.sound = $Node2D/Sound.pressed
	PerformanceMonitor.FPSShown = $Node2D/ShowFPS.pressed
	$Node2D/MusicSlider/Volume.text = String(int( 100 - (($Node2D/MusicSlider.value / -1) / 0.35)))


func _on_LeaveButton_button_down():
	queue_free()
