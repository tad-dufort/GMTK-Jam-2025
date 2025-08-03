extends CharacterBody2D

var health = 5
var speed = 500
var dead = false

func _ready() -> void:
	$AnimationPlayer.play("Down")
	$Sprite2D.frame = 0
func _physics_process(_delta):
	var input_vector = Vector2.ZERO
	input_vector.x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	input_vector.y = Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")
	input_vector = input_vector.normalized()
	

	
	if input_vector == Vector2.ZERO:
		$AudioStreamPlayer2D.stop()
	else:
		$AnimationTree.set("parameters/Walk/blend_position", input_vector)
		if not $AudioStreamPlayer2D.playing:
			$AudioStreamPlayer2D.play()
		
	velocity = input_vector * speed
	move_and_slide()
	
	if health <= 0 and dead == false:
		get_tree().change_scene_to_file("res://Menus/died.tscn")
		dead = true



func _on_hurtbox_area_area_entered(area: Area2D) -> void:
	if area.is_in_group("Enemy"):
		if $Invincibility.is_stopped():
			health -= 1
			$Sprite2D.frame += 1
			$Invincibility.start()
		
	elif area.is_in_group("enemybullet"):
		if $Invincibility.is_stopped():
			health -= 1
			$Sprite2D.frame += 1
			$Invincibility.start()
