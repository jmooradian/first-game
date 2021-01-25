extends Area2D

onready var anim_player: AnimationPlayer = get_node("AnimationPlayer")

export var shields = 10
var picked = false

func _ready():
	if PlayerData.has_shields == false:
		queue_free()

func _on_body_entered(body):
	if picked == false:
		picked()

func picked() -> void:
	PlayerData.shields += shields
	anim_player.play("fade_out")
	picked = true
