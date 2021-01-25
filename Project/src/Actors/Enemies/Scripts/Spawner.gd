extends "res://src/Actors/Enemies/Scripts/Enemy.gd"

func kill():
	var children = preload("res://src/Actors/Enemies/Speed.tscn")
	var rand = RandomNumberGenerator.new()
	for i in range(0,num_children):
		var spawn = children.instance()
		rand.randomize()
		var x = rand.randi_range(0, 1)
		rand.randomize()
		var y = rand.randi_range(0, 1)
		if x == 0:
			x = -1
		if y == 1:
			y = speed.y
		spawn.position = self.position
		
		get_parent().add_child(spawn)
		emit_signal("spawned", Vector2(x * speed.x, 1 * speed.y))

	queue_free()


func _on_Spawn_Enemy_health_updated(health):
	health_bar.update_health(health)

