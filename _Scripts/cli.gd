extends Control

func _on_input_box_text_submitted(new_text: String) -> void:
	print(new_text)
	$InputBox.text = ""


func _on_kill_pressed() -> void:
	GameManager.death()


func _on_add_life_pressed() -> void:
	GameManager.add_life()


func _on_add_hp_pressed() -> void:
	GameManager.add_hp(20)


func _on_spawn_coin_pressed() -> void:
	print("not implemented")
