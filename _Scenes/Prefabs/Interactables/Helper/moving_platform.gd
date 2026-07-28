extends AnimatableBody2D

@export var speed: float = 2.0
@export var pause_duration: float = 1.0

@onready var marker_a: Marker2D = $MarkerA
@onready var marker_b: Marker2D = $MarkerB

func _ready() -> void:
	sync_to_physics = true  # มีใน AnimatableBody2D
	global_position = marker_a.global_position
	start_moving()

func start_moving() -> void:
	# ตั้งค่าให้ Tween ทำงานในจังหวะ Physics (สำคัญมากสำหรับ Godot 4)
	var tween = create_tween().set_process_mode(Tween.TWEEN_PROCESS_PHYSICS)
	tween.set_loops().set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN_OUT)
	
	tween.tween_property(self, "global_position", marker_b.global_position, speed)
	tween.tween_interval(pause_duration)
	tween.tween_property(self, "global_position", marker_a.global_position, speed)
	tween.tween_interval(pause_duration)
