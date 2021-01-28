extends Area2D

onready var anim_player: AnimationPlayer = get_node("AnimationPlayer")

export var gold: = 100
var pickedUp = false

func _on_body_entered(_body):
	if pickedUp == false:
		picked()

func picked() -> void:
	PlayerData.gold += gold
	anim_player.play("fade_out")
	pickedUp = true
