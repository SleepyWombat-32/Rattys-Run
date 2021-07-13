extends Control

func _ready():
	$InfoLabel.text = "You collected all 10 beacons in " + str(round(Globals.time_taken_to_get_all_beacons)) + " Seconds"
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)

func _on_BackButton_pressed():
	get_tree().change_scene("res://GUI/StartScreen.tscn")
