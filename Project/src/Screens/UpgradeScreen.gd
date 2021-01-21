extends Control

onready var gold: Label = get_node("GoldLabel")
onready var healthUpgrade: Label = get_node("HealthLabel")
onready var speedUpgrade: Label = get_node("SpeedLabel")
onready var jumpUpgrade: Label = get_node("JumpLabel")
onready var changeSceneButton: Button = get_node("ChangeSceneButton")

func _ready() -> void:
	changeSceneButton.next_scene_path = PlayerData.curLevel.front()
	gold.text = gold.text % [PlayerData.gold]
	healthUpgrade.text = "$ %s" % PlayerData.healthUpgrades.front()
	speedUpgrade.text = "$ %s" % PlayerData.speedUpgrades.front()
	jumpUpgrade.text = "$ %s" % PlayerData.jumpUpgrades.front()

func update() -> void:
	gold.text = "Your Gold: %s" % PlayerData.gold
	healthUpgrade.text = "$ %s" % PlayerData.healthUpgrades.front()
	speedUpgrade.text = "$ %s" % PlayerData.speedUpgrades.front()
	jumpUpgrade.text = "$ %s" % PlayerData.jumpUpgrades.front()


func _on_UpgradeHealth_button_up():
	if(PlayerData.gold >= PlayerData.healthUpgrades.front()):
		PlayerData.gold -= PlayerData.healthUpgrades.front()
		PlayerData.healthUpgrades.pop_front()
		PlayerData.max_health += 25
	update()

func _on_ChangeSceneButton_button_up():
	PlayerData.curLevel.pop_front()


func _on_UpgradeSpeed_button_up():
	if(PlayerData.gold >= PlayerData.speedUpgrades.front()):
		PlayerData.gold -= PlayerData.speedUpgrades.front()
		PlayerData.speedUpgrades.pop_front()
		PlayerData.speed += 100
	update()


func _on_UpgradeJump_button_up():
	update()
	if(PlayerData.gold >= PlayerData.jumpUpgrades.front()):
		PlayerData.gold -= PlayerData.jumpUpgrades.front()
		PlayerData.jumpUpgrades.pop_front()
		PlayerData.jump += 100
	update()
