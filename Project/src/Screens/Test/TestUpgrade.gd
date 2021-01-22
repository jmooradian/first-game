extends Control

onready var gold: Label = get_node("GoldLabel")
onready var health1U = $"HBoxContainer/Health Group/Health1"
onready var health2U = $"HBoxContainer/Health Group/Health2"
onready var health3U = $"HBoxContainer/Health Group/Health3"
onready var health4U = $"HBoxContainer/Health Group/Health4"

var healthbuttons = [true, false, false, false]

var healthupgrade = 0
var maxhealthupgrades = 4

onready var speedUpgrade: Label = get_node("SpeedLabel")
onready var jumpUpgrade: Label = get_node("JumpLabel")
onready var changeSceneButton: Button = get_node("ChangeSceneButton")

func _ready() -> void:
	changeSceneButton.next_scene_path = PlayerData.curLevel.front()
	update()

func update() -> void:
	gold.text = "Your Gold: %s" % PlayerData.gold
	
	health1U.get_child(0).text = "$ %s" % PlayerData.testhU[0].y
	health1U.get_child(0).visible = healthbuttons[0]
	health1U.disabled = PlayerData.testhU[0].x
	health2U.get_child(0).text = "$ %s" % PlayerData.testhU[1].y
	health2U.get_child(0).visible = healthbuttons[1]
	health2U.disabled = PlayerData.testhU[1].x
	health3U.get_child(0).text = "$ %s" % PlayerData.testhU[2].y
	health3U.get_child(0).visible = healthbuttons[2]
	health3U.disabled = PlayerData.testhU[2].x
	health4U.get_child(0).text = "$ %s" % PlayerData.testhU[3].y
	health4U.get_child(0).visible = healthbuttons[3]
	health4U.disabled = PlayerData.testhU[3].x
	
	speedUpgrade.text = "$ %s" % PlayerData.speedUpgrades.front()
	jumpUpgrade.text = "$ %s" % PlayerData.jumpUpgrades.front()


func _on_UpgradeHealth_button_up():
	var health: float = PlayerData.health
	var max_health: float = PlayerData.max_health
	var healthpercentage: float = health / max_health
	if(PlayerData.gold >= PlayerData.testhU[healthupgrade].y):
		PlayerData.gold -= PlayerData.testhU[healthupgrade].y
		PlayerData.testhU[healthupgrade].x = 1
		healthbuttons[healthupgrade] = false
		if (healthupgrade + 1) < maxhealthupgrades:
			healthupgrade += 1
			PlayerData.testhU[healthupgrade].x = 0
			healthbuttons[healthupgrade] = true
		PlayerData.max_health += 25
		PlayerData.health = healthpercentage * PlayerData.max_health
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
