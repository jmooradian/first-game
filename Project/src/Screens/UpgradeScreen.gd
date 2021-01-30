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
	gold.text = "Your Gold: %s" % PlayerData.get_gold()
	healthUpgrade.text = "$ %s" % UpgradeManager.health.price.front()
	speedUpgrade.text = "$ %s" % UpgradeManager.speed.price.front()
	jumpUpgrade.text = "$ %s" % UpgradeManager.jump.price.front()
	gunUpgrade.text = "$ %s" % UpgradeManager.gun.price.front()
	shieldUpgrade.text = "$ %s" % UpgradeManager.shield.price.front()


func _on_UpgradeHealth_button_up():
	var health = PlayerData.get_health()
	var max_health = PlayerData.get_max_health()
	var healthpercentage = health / max_health
	if(PlayerData.get_gold() >= UpgradeManager.health.price.front()):
		PlayerData.set_gold(PlayerData.get_gold() - UpgradeManager.health.price.front())
		UpgradeManager.health.price.pop_front()
		PlayerData.set_max_health(PlayerData.get_max_health() + 25)
		PlayerData.set_health(float(healthpercentage * PlayerData.get_max_health()))
	update()

func _on_ChangeSceneButton_button_up():
	PlayerData.curLevel.pop_front()


func _on_UpgradeSpeed_button_up():
	if(PlayerData.get_gold() >= UpgradeManager.speed.price.front()):
		PlayerData.set_gold(PlayerData.get_gold() - UpgradeManager.speed.price.front())
		UpgradeManager.speed.price.pop_front()
		PlayerData.set_speed(PlayerData.get_speed() + 100)
	update()


func _on_UpgradeJump_button_up():
	if(PlayerData.get_gold() >= UpgradeManager.jump.price.front()):
		PlayerData.set_gold(PlayerData.get_gold() - UpgradeManager.jump.price.front())
		UpgradeManager.jump.price.pop_front() #UpgradeManager.get("jump").price.pop_front()
		PlayerData.jump += 100
	update()


func _on_UpgradeGun_button_up():
	if(PlayerData.get_gold() >= UpgradeManager.gun.price.front()):
		PlayerData.set_gold(PlayerData.get_gold() - UpgradeManager.gun.price.front())
		UpgradeManager.gun.price.pop_front()
		GunManager.upgrade_damage("pistol", 10)
	update()


func _on_UpgradeShields_button_up():
	var shields = PlayerData.get_shields()
	var max_shields = PlayerData.get_max_shields()
	var shieldpercentage = shields/max_shields
	if(PlayerData.get_gold() >= UpgradeManager.shield.price.front()):
		PlayerData.set_gold(PlayerData.get_gold() - UpgradeManager.shield.price.front())
		if PlayerData.get_has_shields() == false:
			PlayerData.set_has_shields(true)
		else:
			PlayerData.set_max_health(PlayerData.get_max_shields() + 25)
			PlayerData.set_shields(float(shieldpercentage * PlayerData.get_max_shields()))
		UpgradeManager.shield.price.pop_front()
	update()


func _on_RefillHealth_button_up():
	if(PlayerData.get_gold() >= 500 and PlayerData.get_health() != PlayerData.get_max_health()):
		PlayerData.set_gold(PlayerData.get_gold - 500)
		PlayerData.set_health(PlayerData.get_max_health())
	update()


func _on_RefillBullets_button_up():
	if(PlayerData.get_gold() >= 500 and PlayerData.numBullets != PlayerData.maxBullets):
		PlayerData.set_gold(PlayerData.get_gold() - 500)
		PlayerData.numBullets = PlayerData.maxBullets
	update()


func _on_RefillShild_button_up():
	if(PlayerData.get_gold() >= 500 and PlayerData.get_shields() != PlayerData.get_max_shields()):
		PlayerData.set_gold(PlayerData.get_gold() - 500)
		PlayerData.set_shields(PlayerData.get_max_shields())
	update()
