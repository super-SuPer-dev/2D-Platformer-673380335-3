extends Node2D

@export var launch_force: float = -1500.0  # แรงดีด (ค่าติดลบ = พุ่งขึ้นข้างบน)
@export var cooldown: float = 1.5         # เวลาคูลดาวน์ (วินาที)

var is_ready: bool = true

func _on_area_2d_body_entered(body: Node2D) -> void:
	# เช็กว่าชน Player และ Jump Pad พร้อมทำงานหรือไม่
	if body is Player and is_ready:
		is_ready = false
		
		# ส่งแรงดีดให้ Player
		if "velocity" in body:
			body.velocity.y = launch_force
			
			# ถ้า Player มีฟังก์ชันสำหรับจัดการการดีดตัว เช่น เล่นเสียง/แอนิเมชัน
			if body.has_method("bounce"):
				body.bounce()

		# รอคูลดาวน์ก่อนเปิดใช้งานใหม่
		await get_tree().create_timer(cooldown).timeout
		is_ready = true
