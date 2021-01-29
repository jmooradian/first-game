extends Node

signal gold_updated
signal player_died
signal max_health_changed
signal health_changed
signal shields_changed
signal max_shields_changed
signal gave_shields

var position: = Vector2.ZERO setget set_position

var gold: = 0 setget set_gold

var deaths: = 0 setget set_deaths

var max_health: = 100 setget set_max_health
var health: = 100 setget set_health

var shields: = 0 setget set_shields
var max_shields: = 25 setget set_max_shields
var has_shields: = false setget set_give_shields

#Leave for now, but move to GameManager when we have enough to justify a new script
var curLevel = ["res://src/Levels/Level02.tscn","res://src/Levels/LevelTemplate.tscn"]

var curGun = "" setget set_gun

var damage: = 75
var speed: = 300 setget set_speed
var jump: = 1400 setget set_jump

#Move to GunManager
var numBullets : = 10 setget set_numBullets
var maxBullets: = 10 setget set_maxBullets

func reset() -> void:
	gold = 0
	deaths = 0

func set_gold(value: int) -> void:
	gold = value
	emit_signal("gold_updated")

func set_deaths(value: int) -> void:
	deaths = value
	emit_signal("player_died")

func set_max_health(value: int) -> void:
	max_health = value
	emit_signal("max_health_changed")

func set_health(value: int) -> void:
	value = int(clamp(value, 0, max_health))
	health = value
	emit_signal("health_changed")

func set_shields(value: int) -> void:
	value = int(clamp(value, 0, max_shields))
	shields = value
	emit_signal("shields_changed")

func set_max_shields(value: int) -> void:
	max_shields = value
	emit_signal("max_shields_changed")

func set_give_shields(value: bool) -> void:
	has_shields = value
	emit_signal("gave_shields")

func set_speed(value: int) -> void:
	speed = value

func set_jump(value: int) -> void:
	jump = value

func set_position(value: Vector2) -> void:
	position = value

func set_gun(value: String) -> void:
	curGun = value

#Move to GunManager

func set_numBullets(value: int) -> void:
	numBullets = value
	
func set_maxBullets(value: int) -> void:
	maxBullets = value
