extends Node

signal gold_updated
signal player_died
signal max_health_changed
signal health_changed
signal shields_changed
signal max_shields_changed
signal gave_shields

var player = {
	#Health
	health = 100,
	max_health = 100,
	shields = 25,
	max_shields = 25,
	has_shields = false,
	deaths = 0,
	
	#Player Abilities
	jump = 1400,
	speed = 300,
	damage = 75,
	
	gold = 0,
	
	position = Vector2.ZERO,
	
	curGun = ""
}

#Leave for now, but move to GameManager when we have enough to justify a new script
var curLevel = ["res://src/Levels/Level02.tscn","res://src/Levels/LevelTemplate.tscn"]

func reset() -> void:
	player.gold = 0
	player.deaths = 0

#Getters-------------------------------------------------------------
func get_gold() -> int:
	return player.gold

func get_deaths() -> int:
	return player.deaths

func get_max_health() -> float:
	return player.max_health

func get_health() -> float:
	return player.health

func get_max_shields() -> float:
	return player.max_shields

func get_shields() -> float:
	return player.shields

func get_has_shields() -> bool:
	return player.has_shields

func get_speed() -> float:
	return player.speed

func get_jump() -> float:
	return player.jump

func get_position() -> Vector2:
	return player.position

func get_gun() -> String:
	return player.curGun

func get_damage() -> float:
	return player.damage

#Setters-------------------------------------------------------------
func set_gold(value: int) -> void:
	player.gold = value
	emit_signal("gold_updated")

func set_deaths(value: int) -> void:
	player.deaths = value
	emit_signal("player_died")

func set_max_health(value: float) -> void:
	player.max_health = value
	emit_signal("max_health_changed")

func set_health(value: float) -> void:
	value = float(clamp(value, 0, player.max_health))
	player.health = value
	emit_signal("health_changed")

func set_max_shields(value: float) -> void:
	player.max_shields = value
	emit_signal("max_shields_changed")

func set_shields(value: float) -> void:
	value = float(clamp(value, 0, player.max_shields))
	player.shields = value
	emit_signal("shields_changed")

func set_has_shields(value: bool) -> void:
	player.has_shields = value
	emit_signal("gave_shields")

func set_speed(value: float) -> void:
	player.speed = value

func set_jump(value: float) -> void:
	player.jump = value

func set_position(value: Vector2) -> void:
	player.position = value

func set_gun(value: String) -> void:
	player.curGun = value

func set_damage(value: float) -> void:
	player.damage = value
