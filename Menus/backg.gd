extends TextureRect

func _process(delta: float) -> void:
	position.y += 1
	if position.y == 1080:
		position.y = -1080
