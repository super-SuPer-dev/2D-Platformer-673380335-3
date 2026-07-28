extends RigidBody2D

func _ready() -> void:
	$Area2D.monitoring = false
	$Area2D.visible = false

func shoot(direction: Vector2, speed: float, explosion_delay: float = 1, lifetime: float = 1) -> void:
	apply_central_impulse(direction.normalized() * speed)
	
	await get_tree().create_timer(explosion_delay).timeout
	bomb(lifetime)
	
func bomb(lifetime):
	$Area2D.monitoring = true
	$Area2D.visible = true
	$".".freeze = true
	
	await get_tree().create_timer(lifetime).timeout
	queue_free()


func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("Enemy"):
		body.death_tween()
