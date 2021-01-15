extends KinematicBody2D
class_name Actor

signal health_updated(health)
signal killed()

const FLOOR_NORMAL: = Vector2.UP

export var speed: = Vector2(300.0, 1400.0)
export var gravity: = 4000.0

export (float) var max_health = 100

onready var health = max_health setget _set_health

var _velocity: = Vector2.ZERO

func damage(amount):
	_set_health(health-amount)

func kill():
	pass

func _set_health(value):
	var prev_health = health
	health = clamp(value, 0, max_health)
	print(health)
	if health != prev_health:
		emit_signal("health_updated", health)
		if health == 0:
			kill()
			emit_signal("killed")
