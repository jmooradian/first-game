extends Actor

export var stomp_impulse: = 1000.0

onready var p_sprite = $player
onready var p_anim_player = $player/AnimationPlayer
var BULLET_SCENE = preload("res://src/Objects/Bullet.tscn")

var looking = "right"

var respawn_loc: = Vector2(240, -100)
var lives_left: = 3

func _ready():
	speed.x = PlayerData.get_speed()
	speed.y = PlayerData.get_jump()

#Connections---------------------------------------------------------
func _on_EnemyDetector_area_entered(_area):
	_velocity = calculate_stomp_velocity(_velocity, stomp_impulse)

func _on_EnemyDetector_body_entered(body):
	damage(body.dmg)

func _on_JumperDetector_body_entered(body):
	damage(body.jump_dmg)
#--------------------------------------------------------------------

func _process(delta):
	var nogun = Input.is_action_just_released("equip fists")
	var pistol = Input.is_action_just_released("equip pistol")
	var shotgun = Input.is_action_just_released("equp shotgun")
	var rifle = Input.is_action_just_released("equip rifle")
	var rocketlauncher = Input.is_action_just_released("equip rocketlauncher")
	
	if nogun:
		PlayerData.set_gun("")
	elif pistol:
		if GunManager.pistol.hasgun:
			PlayerData.set_gun("pistol")
	elif shotgun:
		if GunManager.shotgun.hasgun:
			PlayerData.set_gun("shotgun")
	elif rifle:
		if GunManager.rifle.hasgun:
			PlayerData.set_gun("rifle")
	elif rocketlauncher:
		if GunManager.rocketlauncher.hasgun:
			PlayerData.set_gun("rocketlauncher")

#Physics-------------------------------------------------------------
func _physics_process(_delta):
	var is_jump_interupted: = Input.is_action_just_released("jump") and _velocity.y < 0.0
	var direction: = get_direction()
	if direction.x == 1.0:
		looking = "right"
		p_anim_player.play("WalkingRight")
	elif direction.x == -1.0:
		looking = "left"
		p_anim_player.play("WalkingLeft")
	
	if Input.is_action_just_released("shoot") and PlayerData.get_gun() != "" and GunManager.guns.get(PlayerData.get_gun()).numbullets > 0:
		GunManager.guns.get(PlayerData.get_gun()).numbullets -= 1
		var bullet = BULLET_SCENE.instance()
		get_parent().add_child(bullet)
		if direction.x == 1.0:
			bullet.set_position(get_node("bulletPos").get_global_position())
		elif direction.x == -1.0:
			bullet.set_position(get_node("bulletPosL").get_global_position())
			bullet.speedDir = -bullet.speedDir
		else:
			if looking == "left":
				bullet.set_position(get_node("bulletPosL").get_global_position())
				bullet.speedDir = -bullet.speedDir
			else:
				bullet.set_position(get_node("bulletPos").get_global_position())
		
	_velocity = calculate_move_velocity(_velocity, direction, speed, is_jump_interupted)
	_velocity = move_and_slide(_velocity, FLOOR_NORMAL)
	
	PlayerData.set_position(self.position)


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
	var shield = PlayerData.player.shields
	
	if shield == 0 || PlayerData.player.has_shields == false:
		PlayerData.set_health(PlayerData.get_health() - value)
	else:
		if (shield - value) >= 0:
			PlayerData.set_health(PlayerData.get_health() - value)
		else:
			var temp = value - shield
			PlayerData.set_shields(0)
			PlayerData.set_health(PlayerData.get_health() - temp)
	
	
	if PlayerData.get_health() == 0:
		die()

func die() -> void:
	PlayerData.set_deaths(PlayerData.get_deaths() + 1)
	queue_free()

func flip(value: bool):
	p_sprite.get_node("torso").flip_h = value
	p_sprite.get_node("leftleg").flip_h = value
	p_sprite.get_node("leftarm").flip_h = value
	p_sprite.get_node("rightleg").flip_h = value
	p_sprite.get_node("rightarm").flip_h = value
#--------------------------------------------------------------------
