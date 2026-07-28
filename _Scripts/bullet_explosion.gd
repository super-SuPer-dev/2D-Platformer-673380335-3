extends RigidBody2D

func shoot(direction: Vector2, speed: float, explosion_delay: float = 0.1, lifetime: float = 0.5) -> void:
	# ส่งแรงไปในทิศทางที่กำหนด
	apply_central_impulse(direction.normalized() * speed)
	
	# รอจนกว่าจะถึงเวลาระเบิด
	await get_tree().create_timer(explosion_delay).timeout
	bomb(lifetime)

func bomb(lifetime: float) -> void:
	# ขยายขนาดเมื่อระเบิด
	scale = Vector2(80.0, 80.0)
	$CollisionShape2D.scale = scale
	# รอเวลาแสดงผลระเบิดแล้วลบ Node ทิ้ง
	await get_tree().create_timer(lifetime).timeout
	queue_free()
