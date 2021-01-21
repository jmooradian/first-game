extends Control

onready var gold: Label = get_node("GoldLabel")

func _ready() -> void:
	gold.text = gold.text % [PlayerData.gold]

func update() -> void:
	gold.text = "Gold: %s" % PlayerData.gold


func _on_UpgradeHealth_button_up():
	PlayerData.gold -= 100
	PlayerData.max_health += 25
	update()


func _on_UpgradeSpeed_button_up():
	PlayerData.gold -= 100
	PlayerData.speed += 100
	update()
