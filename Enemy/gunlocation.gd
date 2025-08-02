extends Node2D


var bulletS = preload("res://Enemy/enemy_bullet.tscn")
var default = Vector2.RIGHT

func shoot(amount):
	for i in range(0, amount):
		var bullet = bulletS.instantiate()
		get_tree().root.add_child(bullet)
		bullet.global_position = global_position
		bullet.global_rotation = global_rotation
		var LaunchDirection = default.rotated(global_rotation + randf_range(-0.2,0.2))
		bullet.launch(LaunchDirection)
