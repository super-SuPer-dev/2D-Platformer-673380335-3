extends Button

func _on_pressed() -> void:
	GameManager.sfx_on = !GameManager.sfx_on
	GameManager.update_option()
	GameManager.save_option()
