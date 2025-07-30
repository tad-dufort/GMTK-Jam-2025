extends CharacterBody2D

@export var target = CharacterBody2D

	
func _physics_process(delta:float):
	if target:
		$NavigationAgent2D.target_position = target.global_position
		velocity = global_position.direction_to($NavigationAgent2D.get_next_path_position()) * 100
		move_and_slide()
	
	

func _on_detection_area_body_entered(body: CharacterBody2D):
	target = body
	

func _on_detection_area_body_exited(body: Node2D) -> void:
	target = null
