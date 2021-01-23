extends Area2D

const BULLET_SPEED =  200
onready var speedDir = 3
func _ready():
	set_process(true)
	
func _process(delta):
	var speed_x = speedDir
	var speed_y = 0
	var motion = Vector2(speed_x, speed_y) * BULLET_SPEED
	set_position(get_position() + motion * delta)

func _on_VisibilityNotifier2D_screen_exited():
	queue_free()


func _on_Bullet_body_entered(body):
	if body.get_name() == "TileMap":
		queue_free()
	elif body.get_name() != "Player":
		body.damage(10)
		queue_free()
