extends Node2D

var bullet = load("res://Player/bullet.tscn")
var scene = bullet.instantiate()
var default = Vector2.RIGHT


func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("shoot") and $Reload.is_stopped():
		shoot()
		$Reload.start()

func shoot():
	var projectile = bullet.instantiate()
	get_tree().root.add_child(projectile)
	projectile.global_position = global_position
	projectile.global_rotation = global_rotation
	var LaunchDirection = default.rotated(global_rotation)
	projectile.launch(LaunchDirection)
	
