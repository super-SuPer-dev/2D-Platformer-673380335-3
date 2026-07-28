extends Node2D

@export var exit_portal: Node2D

@onready var exit_point = $Marker2D
func _on_area_2d_body_entered(body: Node2D) -> void:
	if body as Player:
		if exit_portal:
			body.global_position = exit_portal.exit_point.global_position
			
