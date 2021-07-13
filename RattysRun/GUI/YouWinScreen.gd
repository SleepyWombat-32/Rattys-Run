extends Control

func _ready():
	$InfoLabel.text = "You collected all 10 beacons in " + str(round(Globals.time_taken_to_get_all_beacons)) + " Seconds"


func _on_BackButton_pressed():
	get_tree().change_scene("res://GUI/StartScreen.tscn")
