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
	healthUpgrade.text = "$ %s" % UpgradeManager.health.price.front()
	speedUpgrade.text = "$ %s" % UpgradeManager.speed.price.front()
	jumpUpgrade.text = "$ %s" % UpgradeManager.jump.price.front()
	gunUpgrade.text = "$ %s" % UpgradeManager.gun.price.front()
	shieldUpgrade.text = "$ %s" % UpgradeManager.shield.price.front()


func _on_UpgradeHealth_button_up():
	var health: float = PlayerData.health
	var max_health: float = PlayerData.max_health
	var healthpercentage: float = health / max_health
	print(healthpercentage)
	if(PlayerData.gold >= UpgradeManager.health.price.front()):
		PlayerData.gold -= UpgradeManager.health.price.front()
		UpgradeManager.health.price.pop_front()
		PlayerData.max_health += 25
		print(healthpercentage * PlayerData.max_health)
		PlayerData.health = int(healthpercentage * PlayerData.max_health)
	update()

func _on_ChangeSceneButton_button_up():
	PlayerData.curLevel.pop_front()


func _on_UpgradeSpeed_button_up():
	if(PlayerData.gold >= UpgradeManager.speed.price.front()):
		PlayerData.gold -= UpgradeManager.speed.price.front()
		UpgradeManager.speed.price.pop_front()
		PlayerData.speed += 100
	update()


func _on_UpgradeJump_button_up():
	if(PlayerData.gold >= UpgradeManager.jump.price.front()):
		PlayerData.gold -= UpgradeManager.jump.price.front()
		UpgradeManager.jump.price.pop_front() #UpgradeManager.get("jump").price.pop_front()
		PlayerData.jump += 100
	update()


func _on_UpgradeGun_button_up():
	if(PlayerData.gold >= UpgradeManager.gun.price.front()):
		PlayerData.gold -= UpgradeManager.gun.price.front()
		UpgradeManager.gun.price.pop_front()
		GunManager.upgrade_damage("pistol", 10)
	update()


func _on_UpgradeShields_button_up():
	if(PlayerData.gold >= UpgradeManager.shield.price.front()):
		PlayerData.gold -= UpgradeManager.shield.price.front()
		if UpgradeManager.shield.price.front() == 500:
			PlayerData.has_shields = true
			PlayerData.shields = PlayerData.max_shields
		else:
			PlayerData.max_shields += 25
			#Copy code from health upgrades so you only get a percentage not just max.
			PlayerData.shields = PlayerData.max_shields
		UpgradeManager.shield.price.pop_front()
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
