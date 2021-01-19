extends "res://src/Actors/Enemies/Enemy.gd"

onready var crazytimer = $CrazyTimer
onready var walltimer = $WallTimer

var engagecrazy = true
var rng = RandomNumberGenerator.new()

#Connections---------------------------------------------------------
func _on_CrazyTimer_timeout():
	rng.randomize()
	var my_random_number = rng.randf_range(0.0, 100.0)
	
	if my_random_number > 80.0 && engagecrazy == true:
		_velocity.x *= -1.0

func _on_WallTimer_timeout():
	engagecrazy = true
#--------------------------------------------------------------------

#Physics-------------------------------------------------------------
func _physics_process(delta):
	if is_on_wall():
		walltimer.start()
		engagecrazy = false
#--------------------------------------------------------------------
