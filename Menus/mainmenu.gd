extends CanvasLayer




func _on_play_pressed() -> void:
	$AudioStreamPlayer.play()
	await get_tree().create_timer(1).timeout
	get_tree().change_scene_to_file("res://MainScene/main_scene.tscn")
	

func _on_credits_pressed() -> void:
	$AudioStreamPlayer.play()
	await get_tree().create_timer(1).timeout
	get_tree().change_scene_to_file("res://Menus/credits.tscn")




func _on_audio_stream_player_2_finished() -> void:
	$AudioStreamPlayer3.play()
