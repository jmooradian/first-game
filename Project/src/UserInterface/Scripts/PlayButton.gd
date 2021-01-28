tool
extends Button

export(String, FILE) var next_scene_path: = ""

func _on_button_up():
	var _v = get_tree().change_scene(next_scene_path)
	get_tree().paused = false

func _get_configuration_warning()  -> String:
	return "next screen path must be set to work" if next_scene_path == "" else ""
	
