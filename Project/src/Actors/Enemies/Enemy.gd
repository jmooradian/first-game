extends Actor

onready var health_bar = $HealthBar

func _ready():
	health_bar.visible = false
	set_physics_process(false)
	_velocity.x = -speed.x

func _on_StopDetector_body_entered(body):
	if body.global_position.y > get_node("StopDetector").global_position.y:
		return 
	health_bar.visible = true
	damage(75)
	#get_node("CollisionShape2D").disabled = true
	#die()


func _physics_process(delta):
	_velocity.y += gravity * delta
	if is_on_wall():
		_velocity.x *= -1.0
	_velocity.y = move_and_slide(_velocity, FLOOR_NORMAL).y

func die() -> void:
	queue_free()


func _on_Enemy_health_updated(health):
	health_bar._on_health_updated(health, 0)


func _on_Enemy_killed():
	die()
