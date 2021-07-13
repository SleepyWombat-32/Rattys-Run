extends Spatial


func _on_Area_body_entered(body):
	if body.name == "Player":
		print("beacon entered")
		Globals.beacons_in_world -= 1
		if Globals.beacons_in_world == 0:
			Globals.start_stopwatch(false)
			get_tree().change_scene("res://GUI/YouWinScreen.tscn")
		queue_free()

