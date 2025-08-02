extends Node2D

var bullet = load("res://Player/bullet.tscn")
var scene = bullet.instantiate()
var default = Vector2.RIGHT
var reload = Globals.reload


	

func _process(_delta: float) -> void:
	$Reload.set_wait_time(reload)
	if Input.is_action_pressed("shoot"):
		if $Reload.is_stopped():
			var pew = Globals.pew
			shoot(pew)
			$Reload.start()

	
	
func shoot(amount):
	for i in range (0, amount):
		var spread = Globals.spread
		var projectile = bullet.instantiate()
		get_tree().root.add_child(projectile)
		projectile.global_position = global_position
		projectile.global_rotation = global_rotation
		var LaunchDirection = default.rotated(global_rotation + randf_range(-spread, spread))
		projectile.launch(LaunchDirection)
	
