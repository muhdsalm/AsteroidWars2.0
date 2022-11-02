extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var save_path = "user://save.dat"

# Called when the node enters the scene tree for the first time.
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func saveData():
	var file = File.new()
	var error = file.open(save_path, File.WRITE)
	if error == OK:
		file.store_var({
			"FPSShown": PerformanceMonitor.FPSShown,
			"bestScore": PointSystem.bestScore,
			"music_volume": MusicAutoLoad.music_volume,
			"sound": MusicAutoLoad.sound,
			"golden_asteroids": PointSystem.golden_asteroids,
			"rockets": PointSystem.rockets
	})
	else:
		$AcceptDialog.dialog_text = "Saving game data failed with: " + error
		$AcceptDialog.show()
	
	file.close()
	print("saved")
func loadData():
	var file = File.new()
	if file.file_exists(save_path):
		var error = file.open(save_path, File.READ)
		if error == OK:
			var game_data = file.get_var()
			PerformanceMonitor.FPSShown = game_data["FPSShown"]
			PointSystem.bestScore = game_data["bestScore"]
			MusicAutoLoad.music_volume = game_data["music_volume"]
			MusicAutoLoad.sound = game_data["sound"]
			PointSystem.golden_asteroids = game_data["golden_asteroids"]
			PointSystem.rockets = game_data["rockets"]
		else:
			$AcceptDialog.dialog_text = "Loading Game data failed with: " + error
			$AcceptDialog.show()
		file.close()
	print("locked and loaded")
