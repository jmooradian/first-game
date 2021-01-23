extends Area2D

onready var anim_player: AnimationPlayer = get_node("AnimationPlayer")

var pickedUp = false

func _on_body_entered(_body):
	if pickedUp == false:
		picked()

func picked() -> void:
	if(PlayerData.numBullets < PlayerData.maxBullets):
		PlayerData.numBullets += 1
		#anim_player.play("fade_out")
		pickedUp = true
		queue_free()
