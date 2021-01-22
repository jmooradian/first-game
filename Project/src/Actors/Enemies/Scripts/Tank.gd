extends "res://src/Actors/Enemies/Scripts/Enemy.gd"



func _on_Tank_Enemy_health_updated(health):
	health_bar.update_health(health)

