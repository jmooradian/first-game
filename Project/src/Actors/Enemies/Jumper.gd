extends "res://src/Actors/Enemies/Enemy.gd"

onready var timer = $JumpTimer

#Connections---------------------------------------------------------
func _on_JumpTimer_timeout():
	_velocity.y = move_and_slide(Vector2(_velocity.x, -1.0 * speed.y), FLOOR_NORMAL).y
	timer.start()
#--------------------------------------------------------------------
