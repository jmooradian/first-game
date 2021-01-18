extends Control

onready var gold: Label = get_node("GoldLabel")

func _ready() -> void:
	gold.text = gold.text % [PlayerData.gold]

