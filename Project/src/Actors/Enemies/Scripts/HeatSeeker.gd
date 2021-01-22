extends "res://src/Actors/Enemies/Scripts/Enemy.gd"

func _physics_process(delta):
	print(Vector2(PlayerData.position.x - self.position.x, PlayerData.position.y - self.position.y))
	if is_on_wall():
		_velocity.x = 0
	if (PlayerData.position.x - self.position.x) < 0:
		_velocity.x = -1.0 * self.speed.x
	elif (PlayerData.position.x - self.position.x) > 0:
		_velocity.x = self.speed.x
	else:
		_velocity.x = 0


func _on_HeatSeeker_health_updated(health):
	health_bar.update_health(health)
