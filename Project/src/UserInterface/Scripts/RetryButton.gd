extends Button

func _on_button_up() -> void:
	PlayerData.gold = 0
	get_tree().paused = false
	var _v = get_tree().reload_current_scene()
