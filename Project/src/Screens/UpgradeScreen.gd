extends Control

onready var gold: Label = get_node("GoldLabel")
onready var healthUpgrade: Label = get_node("TabContainer/Player Abilities/HBoxContainer/UpgradeHealth/HealthLabel")
onready var shieldUpgrade: Label = get_node("TabContainer/Player Abilities/HBoxContainer/UpgradeShields/ShieldLabel")
onready var speedUpgrade: Label = get_node("TabContainer/Player Abilities/HBoxContainer2/UpgradeSpeed/SpeedLabel")
onready var jumpUpgrade: Label = get_node("TabContainer/Player Abilities/HBoxContainer2/UpgradeJump/JumpLabel")

onready var shieldBtn: Button = get_node("TabContainer/Player Abilities/HBoxContainer/UpgradeShields")

onready var PistolLabel: Label = get_node("TabContainer/Gun Upgrades/HBoxContainer/UpgradePistol/PistolLabel")
onready var ShotgunLabel: Label = get_node("TabContainer/Gun Upgrades/HBoxContainer/UpgradeShotgun/ShotgunLabel")
onready var RifleLabel: Label = get_node("TabContainer/Gun Upgrades/HBoxContainer2/UpgradeRifle/RifleLabel")
onready var RocketLauncherLabel: Label = get_node("TabContainer/Gun Upgrades/HBoxContainer2/UpgradeRocketLauncher/RocketLauncherLabel")

onready var changeSceneButton: Button = get_node("ChangeSceneButton")

func _ready() -> void:
	changeSceneButton.next_scene_path = PlayerData.curLevel.front()
	update()

func update() -> void:
	if(UpgradeManager.shield.price.front() != 500):
		shieldBtn.text = "Upgrade Shield"
	gold.text = "Your Gold: %s" % PlayerData.get_gold()
	healthUpgrade.text = "$ %s" % UpgradeManager.health.price.front()
	shieldUpgrade.text = "$ %s" % UpgradeManager.shield.price.front()
	speedUpgrade.text = "$ %s" % UpgradeManager.speed.price.front()
	jumpUpgrade.text = "$ %s" % UpgradeManager.jump.price.front()
	PistolLabel.text = "$ %s" % UpgradeManager.pistol.price.front()
	ShotgunLabel.text = "$ %s" % UpgradeManager.shotgun.price.front()
	RifleLabel.text = "$ %s" % UpgradeManager.rifle.price.front()
	RocketLauncherLabel.text = "$ %s" % UpgradeManager.rocketlauncher.price.front()


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

func _on_UpgradePistol_button_up():
	if(PlayerData.get_gold() >= UpgradeManager.pistol.price.front()):
		PlayerData.set_gold(PlayerData.get_gold() - UpgradeManager.pistol.price.front())
		UpgradeManager.pistol.price.pop_front()
		GunManager.upgrade_damage("pistol", 10)
	update()
	
func _on_UpgradeShotgun_button_up():
	if(PlayerData.get_gold() >= UpgradeManager.shotgun.price.front()):
		PlayerData.set_gold(PlayerData.get_gold() - UpgradeManager.shotgun.price.front())
		UpgradeManager.shotgun.price.pop_front()
		GunManager.upgrade_damage("shotgun", 10)
	update()
	
func _on_UpgradeRifle_button_up():
	if(PlayerData.get_gold() >= UpgradeManager.rifle.price.front()):
		PlayerData.set_gold(PlayerData.get_gold() - UpgradeManager.rifle.price.front())
		UpgradeManager.rifle.price.pop_front()
		GunManager.upgrade_damage("rifle", 10)
	update()
	
func _on_UpgradeRocketLauncher_button_up():
	if(PlayerData.get_gold() >= UpgradeManager.rocketlauncher.price.front()):
		PlayerData.set_gold(PlayerData.get_gold() - UpgradeManager.rocketlauncher.price.front())
		UpgradeManager.rocketlauncher.price.pop_front()
		GunManager.upgrade_damage("rocketlauncher", 10)
	update()

func _on_RefillHealth_button_up():
	if(PlayerData.get_gold() >= 500 and PlayerData.get_health() != PlayerData.get_max_health()):
		PlayerData.set_gold(PlayerData.get_gold() - 500)
		PlayerData.set_health(PlayerData.get_max_health())
	update()

func _on_RefillShield_button_up():
	if(PlayerData.get_gold() >= 500 and PlayerData.get_shields() != PlayerData.get_max_shields()):
		PlayerData.set_gold(PlayerData.get_gold() - 500)
		PlayerData.set_shields(PlayerData.get_max_shields())
	update()
	
func _on_ChangeSceneButton_button_up():
	PlayerData.curLevel.pop_front()


func _on_RefillPistolAmmo_button_up():
	if(PlayerData.get_gold() >= 500 and GunManager.guns.get("pistol").numbullets != GunManager.guns.get("pistol").max_numbullets):
		PlayerData.set_gold(PlayerData.get_gold() - 500)
		GunManager.guns.get("pistol").numbullets = GunManager.guns.get("pistol").max_numbullets
	update()


func _on_RefillShotgunAmmo_button_up():
	if(PlayerData.get_gold() >= 500 and GunManager.guns.get("shotgun").numbullets != GunManager.guns.get("shotgun").max_numbullets):
		PlayerData.set_gold(PlayerData.get_gold() - 500)
		GunManager.guns.get("shotgun").numbullets = GunManager.guns.get("shotgun").max_numbullets
	update()


func _on_RefillRifleAmmo_button_up():
	if(PlayerData.get_gold() >= 500 and GunManager.guns.get("rifle").numbullets != GunManager.guns.get("rifle").max_numbullets):
		PlayerData.set_gold(PlayerData.get_gold() - 500)
		GunManager.guns.get("rifle").numbullets = GunManager.guns.get("rifle").max_numbullets
	update()


func _on_RefillRocketAmmo_button_up():
	if(PlayerData.get_gold() >= 500 and GunManager.guns.get("rocketlauncher").numbullets != GunManager.guns.get("rocketlauncher").max_numbullets):
		PlayerData.set_gold(PlayerData.get_gold() - 500)
		GunManager.guns.get("rocketlauncher").numbullets = GunManager.guns.get("rocketlauncher").max_numbullets
	update()
