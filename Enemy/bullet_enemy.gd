extends CharacterBody2D

@export var target = CharacterBody2D
var health = 2
var speed = 125
var chase = false
var bullets = 1
var cd = 1.5
var p_scene = preload("res://Enemy/particle.tscn")
var time = 0.5


func particle():
	var particle = p_scene.instantiate()
	add_child(particle)



func _ready() -> void:
	target = null
	$AnimationPlayer.play("WalkR")
	$Explosion.hide()
	$EnemyAnim.show()
	$HurtboxArea.monitoring = true


func _physics_process(delta:float):
	
	$reload.set_wait_time(cd)
	
	if target:
		$NavigationAgent2D.target_position = target.global_position
		velocity = global_position.direction_to($NavigationAgent2D.get_next_path_position()) * speed
		move_and_slide()
	
	if health <= 0:
		Globals.amount -= 1
		queue_free()
		
	$Particletime.set_wait_time(time)
	
	if $Particletime.is_stopped():
		particle()
		$Particletime.start()
	
	
	
	if chase == true and $reload.is_stopped():
		$anchor/gunlocation.shoot(bullets)
		$reload.start()



func _on_detection_area_body_entered(body: CharacterBody2D):
	if body.is_in_group("Player"):
		chase = true
		target = body
	

func _on_detection_area_body_exited(body: CharacterBody2D) -> void:
	if body.is_in_group("Player"):
		chase = false
		target = null


func _on_hurtbox_area_area_entered(area: Area2D) -> void:
	if area.is_in_group("Bullet"):
		health -= 1
	if area.is_in_group("Player"):
		$EnemyAnim.hide()
		$Explosion.show()
		$AnimationPlayer.play("explode")
		speed = 0
		$HurtboxArea.monitoring = false
	


func _on_animation_player_animation_finished(explode: StringName) -> void:
	health = 0
