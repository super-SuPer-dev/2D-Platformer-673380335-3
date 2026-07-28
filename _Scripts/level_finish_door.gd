extends Area2D

# Define the next scene to load in the inspector
@export var next_scene : PackedScene

func _on_body_entered(body):
	if body.is_in_group("Player") && next_scene != null:
		AudioManager.level_complete_sfx.play()
		GameManager.load_level(next_scene)
