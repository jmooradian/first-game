extends Area2D

onready var anim_player: AnimationPlayer = get_node("AnimationPlayer")

export var gold: = 100

func _on_body_entered(_body):
	picked()

func picked() -> void:
	PlayerData.gold += gold
	anim_player.play("fade_out")
