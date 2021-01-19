extends Control

signal health_updated(health)
signal killed

onready var scene_tree: = get_tree()
onready var pause_overlay: ColorRect = get_node("PauseOverlay")
onready var gold: Label = get_node("Label")
onready var pause_title: Label = get_node("PauseOverlay/Title")
onready var health_bar = $HealthBar

var paused: = false setget set_paused

func _ready() -> void:
	PlayerData.connect("gold_updated", self, "update_interface")
	PlayerData.connect("player_died", self, "_on_PlayerData_player_died")
	PlayerData.connect("max_health_changed", self, "update_max_health")
	PlayerData.connect("health_changed", self, "update_health")
	update_interface()

func _on_PlayerData_player_died() -> void:
	self.paused = true
	pause_title.text = "You died"
	
	

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("pause"):
		self.paused = not paused
		scene_tree.set_input_as_handled()

func update_interface() -> void:
	gold.text = "Gold: %s" % PlayerData.gold
	health_bar.get_child(0).value = PlayerData.health
	health_bar.get_child(1).value = PlayerData.health

func set_paused(value: bool) -> void:
	paused = value
	scene_tree.paused = value
	pause_overlay.visible = value

func update_health() -> void:
	var prev_health = health_bar.get_child(0).value
	var curr_health = PlayerData.health
	curr_health = clamp(curr_health, 0, PlayerData.max_health)
	if curr_health != prev_health:
		health_bar.update_health(curr_health)

func update_max_health() -> void:
	pass
