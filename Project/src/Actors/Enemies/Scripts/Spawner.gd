extends "res://src/Actors/Enemies/Scripts/Enemy.gd"

func kill():
	var children = preload("res://src/Actors/Enemies/Speed.tscn")
	var rand = RandomNumberGenerator.new()
	for _i in range(0,num_children):
		var spawn = children.instance()
		rand.randomize()
		var x = rand.randf_range(0, 1)
		rand.randomize()
		var y = rand.randf_range(-1, 0)
		if x == 0:
			x = -1
			
		spawn.position = self.position
		spawn._velocity = Vector2(x * speed.x, y * speed.y)
		
		get_parent().call_deferred("add_child", spawn)

	queue_free()


func _on_Spawn_Enemy_health_updated(health):
	health_bar.update_health(health)

