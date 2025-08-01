extends Node2D

@onready var spawnArea = $SpawnZone.shape.extents
@onready var origin = $SpawnZone.global_position -  spawnArea
@onready var loop = 1
@onready var enemy = load("res://Enemy/Enemy.tscn")
@onready var Spawned = enemy.instantiate()


func spawn():
	get_tree().root.add_child(Spawned)
	var x = randf_range(origin.x, spawnArea.x)
	var y = randf_range(origin.y, spawnArea.y)
	Spawned.speed *= loop
	Spawned.global_position = Vector2(x,y)


func _on_end_zone_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"): #and Spawned.amount == 0:
		$Player.global_position.x -= 5000
		loop += 1
		if loop <= 5:
			for i in range(0, loop):
				spawn()
				Spawned.amount += 1
				
