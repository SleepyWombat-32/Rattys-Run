extends Control

func _process(delta):
	$SecondsLabel.text = str(round(Globals.time_taken_to_get_all_beacons)) + " Seconds past"
	$BeaconsLabel.text = str(Globals.beacons_in_world) + " Beacons left"
