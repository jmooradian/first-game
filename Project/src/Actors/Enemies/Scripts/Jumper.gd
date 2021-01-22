extends "res://src/Actors/Enemies/Scripts/Enemy.gd"

onready var timer = $JumpTimer

#Connections---------------------------------------------------------
func _on_JumpTimer_timeout():
	_velocity.y = move_and_slide(Vector2(_velocity.x, -1.0 * speed.y), FLOOR_NORMAL).y
	timer.start()
#--------------------------------------------------------------------


func _on_Jump_Enemy_health_updated(health):
	health_bar.update_health(health)

