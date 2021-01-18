extends Node

signal gold_updated
signal player_Died

var gold: = 0 setget set_gold
var deaths: = 0 setget set_deaths

func reset() -> void:
	gold = 0
	deaths = 0

func set_gold(value: int) -> void:
	gold = value
	emit_signal("gold_updated")

func set_deaths(value: int) -> void:
	deaths = value
	emit_signal("player_Died")
