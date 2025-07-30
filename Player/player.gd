extends CharacterBody2D
var bullet = load("res://Player/bullet.tscn")
var scene = bullet.instantiate()

func _physics_process(delta):
	var input_vector = Vector2.ZERO
	input_vector.x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	input_vector.y = Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")
	input_vector = input_vector.normalized()
	
	velocity = input_vector * 300
	move_and_slide()
	
	
	
	if Input.is_action_just_pressed("shoot"):
		shoot()

		
func shoot():
	var scene = bullet.instantiate()
	get_tree().root.add_child(scene)
	scene.global_position = $Marker2D.global_position
	
