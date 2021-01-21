extends Area2D

onready var anim_player: AnimationPlayer = get_node("AnimationPlayer")

export var health: = 10
var picked = false

func _on_body_entered(_body):
	if picked == false:
		picked()

func picked() -> void:
	PlayerData.health += health
	anim_player.play("fade_out")
	picked = true
