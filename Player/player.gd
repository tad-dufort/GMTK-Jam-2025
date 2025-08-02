extends CharacterBody2D

var health = 5
var speed = 1000

func _ready() -> void:
	$AnimationPlayer.play("Down")

func _physics_process(_delta):
	var input_vector = Vector2.ZERO
	input_vector.x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	input_vector.y = Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")
	input_vector = input_vector.normalized()
	
	velocity = input_vector * speed
	move_and_slide()
	
	if health <= 0:
		get_tree().change_scene_to_file("res://Menus/died.tscn")




func _on_hurtbox_area_area_entered(area: Area2D) -> void:
	if area.is_in_group("Enemy"):
		if $Invincibility.is_stopped():
			health -= 1
			$Invincibility.start()
		
	elif area.is_in_group("enemybullet"):
		if $Invincibility.is_stopped():
			health -= 1
			print_debug(health)
			$Invincibility.start()
