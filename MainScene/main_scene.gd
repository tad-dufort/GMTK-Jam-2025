extends Node2D

@onready var spawnArea = $Spawnzone/SpawnZone.shape.extents
@onready var origin = $Spawnzone/SpawnZone.global_position -  spawnArea
@onready var loop = 1
@onready var enemy = preload("res://Enemy/Enemy.tscn")
@onready var gunenemy = preload("res://Enemy/bullet_enemy.tscn")




func _process(delta: float) -> void:
	if loop == 5:
		loop = 0
	if (Globals.total % 5) == 0:
		Globals.despawn = 10
func spawn():
	var Spawned = enemy.instantiate()
	add_child(Spawned)
	var x = randf_range(origin.x, spawnArea.x)
	var y = randf_range(origin.y, spawnArea.y)
	Spawned.speed *= loop
	Spawned.health += ceil(loop/2)
	Spawned.global_position = Vector2(x,y)
	Spawned.time /= loop
	Globals.amount += 1

func spawngun():
	var gun = gunenemy.instantiate()
	add_child(gun)
	var x = randf_range(origin.x, spawnArea.x)
	var y = randf_range(origin.y, spawnArea.y)
	gun.bullets = loop
	gun.cd /= loop
	gun.time /= loop
	gun.health += ceil(loop/2)
	gun.global_position = Vector2(x,y)
	Globals.amount += 1
	

func _ready():
	get_node("/root/Player").global_position = $Node2D.global_position
	spawn()

func _on_end_zone_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player") and Globals.amount == 0:
		get_node("/root/Player").global_position.x -= 6000
		loop += 1
		Globals.despawn = 10
		Globals.despawn /= loop
		Globals.total += 1
		if Globals.total < 5:
			for i in range(0, loop):
				spawn()
		elif Globals.total >= 5 and Globals.total < 10:
			for i in range(0, loop):
				spawngun()
		elif Globals.total >= 10 and Globals.total < 15:
			for i in range(0, loop):
				spawngun()
				spawn()
