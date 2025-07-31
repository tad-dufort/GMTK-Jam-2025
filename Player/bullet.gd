extends RigidBody2D

var speed = 500

func _ready() -> void:
	$BulletAnim.play("Fly")
	
func launch(MoveDirection: Vector2):
	linear_velocity = MoveDirection * speed


func _on_hitbox_area_body_entered(body: Node2D) -> void:
	if body.is_in_group("Walls"):
		queue_free()



func _on_hitbox_area_area_entered(area: Area2D) -> void:
	if area.is_in_group("Enemy"):
		queue_free()
