extends "res://src/Actors/Enemies/Enemy.gd"

func _on_Speed_Enemy_health_updated(health):
	health_bar._on_health_updated(health, 0)


func _on_Speed_Enemy_killed():
	die()
