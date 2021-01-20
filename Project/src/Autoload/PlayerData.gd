extends Node

signal gold_updated
signal player_died
signal max_health_changed
signal health_changed
signal shields_changed
signal max_shields_changed

var gold: = 0 setget set_gold
var deaths: = 0 setget set_deaths
var max_health: = 100 setget set_max_health
var health: = 100 setget set_health
var shields: = 0 setget set_shields
var max_shields: = 100 setget set_max_shields

func reset() -> void:
	gold = 0
	deaths = 0

func set_gold(value: int) -> void:
	gold = value
	emit_signal("gold_updated")

func set_deaths(value: int) -> void:
	deaths = value
	emit_signal("player_died")

func set_max_health(value: int) -> void:
	max_health = value
	emit_signal("max_health_changed")

func set_health(value: int) -> void:
	value = clamp(value, 0, max_health)
	health = value
	emit_signal("health_changed")

func set_shields(value: int) -> void:
	value = clamp(value, 0, max_shields)
	shields = value
	emit_signal("shields_changed")

func set_max_shields(value: int) -> void:
	max_shields = value
	emit_signal("max_shields_changed")
