extends Control


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var SettingsButton: PackedScene = load("res://Scenes/PauseMenuSettings.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	Saver.saveData()
	MusicAutoLoad.StopMusic()

func _process(delta):
	$TimerLabel/Label.text = String(int($Timer.time_left) + 1)

# Called every frame. 'delta' is the elapsed time since the previous frame.

func _on_Resume_button_down():
	MusicAutoLoad.Click()
	$TimerLabel.visible = true
	$PauseMenuPageSmall.visible = false
	$Resume.queue_free()
	$Settings.queue_free()
	$LeaveGame.queue_free()
	$Timer.start()

func _on_Settings_button_down():
	
	MusicAutoLoad.Click()
	add_child(SettingsButton.instance())
	


func _on_LeaveGame_button_down():
	
	MusicAutoLoad.StopMusic()
	MusicAutoLoad.StopInGameMusic()
	MusicAutoLoad.Click()
	get_tree().paused = false
	get_tree().change_scene("res://Scenes/Main Menu.tscn")
	PointSystem.paused = false


func _on_Timer_timeout():
	get_tree().paused = false
	MusicAutoLoad.PlayMusic()
	queue_free()
	MusicAutoLoad.StopMusic()
	PointSystem.paused = false
