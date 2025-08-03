extends Node2D

@onready var spawnArea = $Spawnzone/SpawnZone.shape.extents
@onready var origin = $Spawnzone/SpawnZone.global_position -  spawnArea
@onready var loop = 1
@onready var enemy = preload("res://Enemy/Enemy.tscn")
@onready var gunenemy = preload("res://Enemy/bullet_enemy.tscn")
@onready var upgrade = true
var finalamount = 0


func _process(delta: float) -> void:
	if loop == 5 and Globals.total <= 15:
		loop = 0
		upgrade = false
	if (Globals.total % 5) == 0 and upgrade == false:
		Globals.despawn = 15
		Globals.pew += 1
		Globals.spread += 0.1
		Globals.reload /= 1.3
		get_node("/root/Player").speed += 150
		upgrade = true
	

func spawn():
	var Spawned = enemy.instantiate()
	add_child(Spawned)
	var x = randf_range(origin.x, spawnArea.x)
	var y = randf_range(origin.y, spawnArea.y)
	Spawned.speed *= float(loop)/2
	Spawned.health += float(loop)/2
	Spawned.global_position = Vector2(x,y)
	Spawned.time /= float(loop)/2
	Globals.amount += 1

func spawngun():
	var gun = gunenemy.instantiate()
	Globals.despawn = 7.5
	add_child(gun)
	var x = randf_range(origin.x, spawnArea.x)
	var y = randf_range(origin.y, spawnArea.y)
	gun.bullets = loop
	gun.cd /= loop

	gun.health += float(loop)/3
	gun.global_position = Vector2(x,y)
	Globals.amount += 1
	

func _ready():
	$Player.global_position = $Spawntile.global_position
	spawngun()
	Globals.despawn /= float(loop)/2


func _on_end_zone_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player") and Globals.amount == 0:
		$Player.global_position.x -= 6000
		loop += 1
		Globals.despawn = 15.0
		Globals.despawn /= float(loop)/2
		Globals.total += 1
		
		if finalamount < 5:
			finalamount += 1
		
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
		elif Globals.total >= 15:
			for i in range(0, finalamount):
				spawngun()
				spawngun()
				spawn()
