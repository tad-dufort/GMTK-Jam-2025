extends Node2D

@export var default = Vector2.RIGHT

func _process(delta: float) -> void:
	var cursor = get_global_mouse_position()
	var angle = global_position.angle_to_point(cursor)
	rotation = angle
