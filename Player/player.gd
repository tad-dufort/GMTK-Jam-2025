extends CharacterBody2D

var health = 5

func _ready() -> void:
	$AnimationPlayer.play("Idle")

func _physics_process(delta):
	var input_vector = Vector2.ZERO
	input_vector.x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	input_vector.y = Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")
	input_vector = input_vector.normalized()
	
	velocity = input_vector * 300
	move_and_slide()
	
	#if health <= 0:
		


func _on_hurtbox_area_area_entered(area: Area2D) -> void:
	if area.is_in_group("Enemy") and $Invincibility.is_stopped():
		health -= 1
		$Invincibility.start()
		print_debug(health)


func _on_area_2d_area_entered(area: Area2D) -> void:
	pass # Replace with function body.
