extends Control

onready var scene_tree: = get_tree()
onready var pause_overlay: ColorRect = get_node("PauseOverlay")
onready var gold: Label = get_node("GoldLabel")
onready var bullets: Label = get_node("BulletsLabel")
onready var pause_title: Label = get_node("PauseOverlay/Title")
onready var health_bar = $HealthBar
onready var shield_bar = $ShieldBar
onready var gunimg = $GunImg

var paused: = false setget set_paused

func _ready() -> void:
# warning-ignore:return_value_discarded
	PlayerData.connect("gold_updated", self, "update_interface")
# warning-ignore:return_value_discarded
	PlayerData.connect("player_died", self, "_on_PlayerData_player_died")
# warning-ignore:return_value_discarded
	PlayerData.connect("max_health_changed", self, "update_max_health")
# warning-ignore:return_value_discarded
	PlayerData.connect("health_changed", self, "update_health")
# warning-ignore:return_value_discarded
	PlayerData.connect("shields_changed", self, "update_shields")
# warning-ignore:return_value_discarded
	PlayerData.connect("max_shields_changed", self, "update_max_shields")
# warning-ignore:return_value_discarded
	PlayerData.connect("gave_shields", self, "give_shields")
	update_interface()

func _on_PlayerData_player_died() -> void:
	self.paused = true
	pause_title.text = "You died"
	
	

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("pause"):
		self.paused = not paused
		scene_tree.set_input_as_handled()

func _process(_delta):
	if PlayerData.get_gun() == "":
		bullets.visible = false
		gunimg.texture = null
	else:
		bullets.visible = true
		bullets.text = "Bullets: %s / %s" % [GunManager.guns.get(PlayerData.get_gun()).numbullets, GunManager.guns.get(PlayerData.get_gun()).max_numbullets]
		gunimg.texture = load(GunManager.guns.get(PlayerData.get_gun()).img)

func update_interface() -> void:
	gold.text = "Gold: %s" % PlayerData.get_gold()
	health_bar.get_child(0).max_value = PlayerData.get_max_health()
	health_bar.get_child(1).max_value = PlayerData.get_max_health()
	health_bar.get_child(0).value = PlayerData.get_health()
	health_bar.get_child(1).value = PlayerData.get_health()
	
	shield_bar.get_child(0).max_value = PlayerData.get_max_shields()
	shield_bar.get_child(1).max_value = PlayerData.get_max_shields()
	shield_bar.get_child(0).value = PlayerData.get_shields()
	shield_bar.get_child(1).value = PlayerData.get_shields()
	
	if PlayerData.get_has_shields() == false:
		shield_bar.visible = false

func set_paused(value: bool) -> void:
	paused = value
	scene_tree.paused = value
	pause_overlay.visible = value

func update_health() -> void:
	var prev_health = health_bar.get_child(0).value
	var curr_health = PlayerData.get_health()
	curr_health = clamp(curr_health, 0, PlayerData.get_max_health())
	if curr_health != prev_health:
		health_bar.update_health(curr_health)

func update_max_health() -> void:
	health_bar.update_max_health(PlayerData.get_max_health())

func update_shields() -> void:
	var prev_shields = shield_bar.get_child(0).value
	var curr_shields = PlayerData.get_shields()
	curr_shields = clamp(curr_shields, 0, PlayerData.get_max_shields())
	if curr_shields != prev_shields:
		shield_bar.update_shields(curr_shields)

func update_max_shields() -> void:
	shield_bar.update_max_shield(PlayerData.get_max_shields())

func give_shields() -> void:
	shield_bar.visible = true
	PlayerData.set_shields(PlayerData.get_max_shields())
