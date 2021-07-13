extends Node

var beacons_in_world : int = 0
var beacons_to_spawn : int = 10
var time_taken_to_get_all_beacons = 0.0


func _ready():
	set_physics_process(false)
func start_stopwatch(t_f):
	if t_f:
		set_physics_process(true)
	else:
		set_physics_process(false)
func _physics_process(delta):
	time_taken_to_get_all_beacons += delta
