extends CanvasLayer

func _ready() -> void:
	$Control/AnimatedSprite2D.play("dead")

func _on_back_pressed() -> void:
	$AudioStreamPlayer3.play()
	await get_tree().create_timer(1).timeout
	get_tree().change_scene_to_file("res://Menus/mainmenu.tscn")
	
