extends Area2D

onready var anim_player: AnimationPlayer = get_node("AnimationPlayer")

var pickedUp = false

func _on_body_entered(_body):
	if pickedUp == false:
		picked()

func picked() -> void:
	if(PlayerData.get_gun() != ""):
		if(GunManager.guns.get(PlayerData.get_gun()).numbullets < GunManager.guns.get(PlayerData.get_gun()).max_numbullets):
			GunManager.guns.get(PlayerData.get_gun()).numbullets += 1
			anim_player.play("fade_out")
			pickedUp = true
