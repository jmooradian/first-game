extends Actor

signal health_updated(health)

export (float) var max_health = 100

onready var _health = max_health setget _set_health
onready var health_bar = $HealthBar

#Ready---------------------------------------------------------------
func _ready():
	health_bar.visible = false
	set_physics_process(false)
	_velocity.x = -speed.x
#--------------------------------------------------------------------

#Connections---------------------------------------------------------
func _on_StopDetector_body_entered(body):
	if body.global_position.y > get_node("StopDetector").global_position.y:
		return 
	health_bar.visible = true
	damage(75)
	#get_node("CollisionShape2D").disabled = true
	#die()

func _on_Enemy_health_updated(health):
	health_bar.update_health(health)
#--------------------------------------------------------------------

#Physics-------------------------------------------------------------
func _physics_process(delta):
	_velocity.y += gravity * delta
	if is_on_wall():
		_velocity.x *= -1.0
	_velocity.y = move_and_slide(_velocity, FLOOR_NORMAL).y
#--------------------------------------------------------------------

#Enemy Damage--------------------------------------------------------
func damage(amount):
	_set_health(_health-amount)

func kill():
	queue_free()

func _set_health(value):
	var prev_health = _health
	_health = clamp(value, 0, max_health)
	if _health != prev_health:
		emit_signal("health_updated", _health)
		if _health == 0:
			kill()
#--------------------------------------------------------------------
