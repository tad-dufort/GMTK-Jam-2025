extends CharacterBody2D

@export var target = CharacterBody2D
var health = 2
var speed = 100


func _ready() -> void:
	target = null
	$AnimationPlayer.play("WalkR")
	$Explosion.hide()
	$EnemyAnim.show()
	$HurtboxArea.monitoring = true
	
func _physics_process(delta:float):
	if target:
		$NavigationAgent2D.target_position = target.global_position
		velocity = global_position.direction_to($NavigationAgent2D.get_next_path_position()) * speed
		move_and_slide()
	
	if health <= 0:
		queue_free()
	
	if $AnimationPlayer.is_playing() == false:
		queue_free()

func _on_detection_area_body_entered(body: CharacterBody2D):
	if body.is_in_group("Player"):
		target = body
	

func _on_detection_area_body_exited(body: CharacterBody2D) -> void:
	if body.is_in_group("Player"):
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
