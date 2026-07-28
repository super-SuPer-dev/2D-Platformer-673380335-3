extends Button

@export var exitToScene : PackedScene

func _on_pressed() -> void:
	AudioManager.click_sfx.play()
	if exitToScene != null:
		SceneTransition.load_scene(exitToScene)
	else:
		#get_tree().change_scene_to_file("res://Scenes/Levels/menu.tscn")
		GameManager.load_game()
