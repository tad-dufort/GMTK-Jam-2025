extends CanvasLayer


func _on_back_pressed() -> void:
	$AudioStreamPlayer2.play()
	await get_tree().create_timer(1).timeout
	get_tree().change_scene_to_file("res://Menus/mainmenu.tscn")
