extends Button



func _on_pressed() -> void:
	AudioManager.click_sfx.play()
	get_tree().change_scene_to_file("res://_Scenes/Levels/menu.tscn")
