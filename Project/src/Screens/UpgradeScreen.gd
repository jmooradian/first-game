extends Control

onready var gold: Label = get_node("GoldLabel")
onready var healthUpgrade: Label = get_node("HealthLabel")
onready var changeSceneButton: Button = get_node("ChangeSceneButton")

func _ready() -> void:
	changeSceneButton.next_scene_path = PlayerData.curLevel.front()
	gold.text = gold.text % [PlayerData.gold]
	healthUpgrade.text = "$ %s" % PlayerData.healthUpgrades.front()

func update() -> void:
	gold.text = "Your Gold: %s" % PlayerData.gold
	healthUpgrade.text = "$ %s" % PlayerData.healthUpgrades.front()


func _on_UpgradeHealth_button_up():
	if(PlayerData.gold >= PlayerData.healthUpgrades.front()):
		PlayerData.gold -= PlayerData.healthUpgrades.front()
		PlayerData.healthUpgrades.pop_front()
		PlayerData.max_health += 25
	update()
	
func _on_ChangeSceneButton_button_up():
	PlayerData.curLevel.pop_front()
