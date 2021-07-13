extends Spatial


func _on_Area_body_entered(body):
	if body.name == "Player":
		print("beacon entered")
		Globals.beacons_in_world -= 1
		queue_free()
