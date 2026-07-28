extends Button

func _on_pressed() -> void:
	GameManager.music_on = !GameManager.music_on
	GameManager.update_option()
	GameManager.save_option()
