extends Control

@onready var btn_continue: Button = $Node2D/VBoxContainer/btnContinue

func _ready() -> void:
	#DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
	#$CenterContainer.size = get_viewport_rect().size
	
	btn_continue.disabled = !GameManager.has_gamesaved()
	GameManager.load_option()

func _on_btn_start_pressed() -> void:
	AudioManager.click_sfx.play()
	#DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_EXCLUSIVE_FULLSCREEN)
	GameManager.full_restart()

func _on_btn_option_pressed() -> void:
	AudioManager.click_sfx.play()
	get_tree().change_scene_to_file("res://_Scenes/Levels/UI/options.tscn")


func _on_btn_credit_pressed() -> void:
	AudioManager.click_sfx.play()
	get_tree().change_scene_to_file("res://_Scenes/Levels/UI/credit.tscn")


func _on_btn_continue_pressed() -> void:
	AudioManager.click_sfx.play()
	GameManager.load_game()


func _on_btn_exit_pressed() -> void:
	AudioManager.click_sfx.play()
	await get_tree().create_timer(AudioManager.jump_sfx.stream.get_length()).timeout
	get_tree().quit()


func _on_btn_test_pressed() -> void:
	AudioManager.click_sfx.play()
	get_tree().change_scene_to_file("res://_Scenes/Tests/test_area.tscn")
