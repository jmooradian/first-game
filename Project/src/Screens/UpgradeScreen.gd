extends Control

onready var gold: Label = get_node("GoldLabel")
onready var healthUpgrade: Label = get_node("HealthLabel")
onready var speedUpgrade: Label = get_node("SpeedLabel")
onready var jumpUpgrade: Label = get_node("JumpLabel")
onready var gunUpgrade: Label = get_node("GunLabel")
onready var shieldUpgrade: Label = get_node("ShieldLabel")
onready var changeSceneButton: Button = get_node("ChangeSceneButton")

func _ready() -> void:
	changeSceneButton.next_scene_path = PlayerData.curLevel.front()
	update()

func update() -> void:
	gold.text = "Your Gold: %s" % PlayerData.gold
	healthUpgrade.text = "$ %s" % PlayerData.healthUpgrades.front()
	speedUpgrade.text = "$ %s" % PlayerData.speedUpgrades.front()
	jumpUpgrade.text = "$ %s" % PlayerData.jumpUpgrades.front()
	gunUpgrade.text = "$ %s" % PlayerData.gunUpgrades.front()
	shieldUpgrade.text = "$ %s" % PlayerData.shieldUpgrades.front()


func _on_UpgradeHealth_button_up():
	var health: float = PlayerData.health
	var max_health: float = PlayerData.max_health
	var healthpercentage: float = health / max_health
	print(healthpercentage)
	if(PlayerData.gold >= PlayerData.healthUpgrades.front()):
		PlayerData.gold -= PlayerData.healthUpgrades.front()
		PlayerData.healthUpgrades.pop_front()
		PlayerData.max_health += 25
		print(healthpercentage * PlayerData.max_health)
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


func _on_UpgradeGun_button_up():
	if(PlayerData.gold >= PlayerData.gunUpgrades.front()):
		PlayerData.gold -= PlayerData.gunUpgrades.front()
		PlayerData.gunUpgrades.pop_front()
		PlayerData.bulletDamage += 10
	update()


func _on_UpgradeShields_button_up():
	if(PlayerData.gold >= PlayerData.shieldUpgrades.front()):
		PlayerData.gold -= PlayerData.shieldUpgrades.front()
		if PlayerData.shieldUpgrades.front() == 500:
			PlayerData.has_shields = true
			PlayerData.shields = PlayerData.max_shields
		else:
			PlayerData.shields += 25
		PlayerData.shieldUpgrades.pop_front()
	update()


func _on_RefillHealth_button_up():
	if(PlayerData.gold >= 500 and PlayerData.health != PlayerData.max_health):
		PlayerData.gold -= 500
		PlayerData.health = PlayerData.max_health
		update()


func _on_RefillBullets_button_up():
	if(PlayerData.gold >= 500 and PlayerData.numBullets != PlayerData.maxBullets):
		PlayerData.gold -= 500
		PlayerData.numBullets = PlayerData.maxBullets
		update()


func _on_RefillShild_button_up():
	if(PlayerData.gold >= 500 and PlayerData.shields != PlayerData.max_shields):
		PlayerData.gold -= 500
		PlayerData.shields = PlayerData.max_shields
		update()
