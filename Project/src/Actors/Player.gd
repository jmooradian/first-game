extends Actor

export var stomp_impulse: = 1000.0

onready var larrow = $leftarrow
onready var rarrow = $rightarrow
var BULLET_SCENE = preload("res://src/Objects/Bullet.tscn")

var respawn_loc: = Vector2(240, -100)
var lives_left: = 3

func _ready():
	speed.x = PlayerData.speed
	speed.y = PlayerData.jump

#Connections---------------------------------------------------------
func _on_EnemyDetector_area_entered(_area):
	_velocity = calculate_stomp_velocity(_velocity, stomp_impulse)

func _on_EnemyDetector_body_entered(body):
	damage(body.dmg)

func _on_JumperDetector_body_entered(body):
	damage(body.jump_dmg)
#--------------------------------------------------------------------

#Physics-------------------------------------------------------------
func _physics_process(_delta):
	
	var is_jump_interupted: = Input.is_action_just_released("jump") and _velocity.y < 0.0
	var direction: = get_direction()
	if direction.x == 1.0:
		rarrow.visible = true
		larrow.visible = false
	elif direction.x == -1.0:
		rarrow.visible = false
		larrow.visible = true
	if Input.is_action_just_released("shoot") and PlayerData.numBullets > 0:
		PlayerData.numBullets -= 1
		var bullet = BULLET_SCENE.instance()
		get_parent().add_child(bullet)
		if direction.x == 1.0:
			bullet.set_position(get_node("bulletPos").get_global_position())
		elif direction.x == -1.0:
			bullet.set_position(get_node("bulletPosL").get_global_position())
			bullet.speedDir = -bullet.speedDir
		else:
			if larrow.visible == true:
				bullet.set_position(get_node("bulletPosL").get_global_position())
				bullet.speedDir = -bullet.speedDir
			else:
				bullet.set_position(get_node("bulletPos").get_global_position())
		
	_velocity = calculate_move_velocity(_velocity, direction, speed, is_jump_interupted)
	_velocity = move_and_slide(_velocity, FLOOR_NORMAL)
	
	PlayerData.position = self.position


func get_direction() -> Vector2:
	return Vector2(
		Input.get_action_strength("move_right") - Input.get_action_strength("move_left"),
		-1.0 if Input.is_action_just_pressed("jump") and is_on_floor() else 0.0
	)

func calculate_move_velocity(
		linear_velocity: Vector2,
		direction: Vector2,
		speed: Vector2,
		is_jump_interrupted: bool
	) -> Vector2:
	var out = linear_velocity
	out.x = speed.x * direction.x
	out.y += gravity * get_physics_process_delta_time()
	if direction.y == -1.0:
		out.y = speed.y * direction.y
	if is_jump_interrupted:
		out.y = 0.0
	return out

func calculate_stomp_velocity(linear_velocity: Vector2, impulse: float) -> Vector2:
	var out: = linear_velocity
	out.y = -impulse
	return out
#--------------------------------------------------------------------

#--------------------------------------------------------------------
func damage(value: int):
	var shield = PlayerData.shields
	
	if shield == 0 || PlayerData.has_shields == false:
		PlayerData.health -= value
	else:
		if (shield - value) >= 0:
			PlayerData.shields -= value
		else:
			var temp = value - shield
			PlayerData.shields = 0
			PlayerData.health -= temp
	
	
	if PlayerData.health == 0:
		die()

func die() -> void:
	PlayerData.deaths += 1
	queue_free()
#--------------------------------------------------------------------
