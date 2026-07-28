extends Button

@export var exitToScene : PackedScene
@export var play : bool = false

func _on_pressed() -> void:
	AudioManager.click_sfx.play()
	if play:
		GameManager.full_restart()
		return
	SceneTransition.load_scene(load("res://_Scenes/Levels/menu.tscn"))
