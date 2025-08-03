extends Node2D


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
		$Player.speed += 150
		upgrade = true
		
	if Globals.amount == 0:
		$TileMapLayer2.hide()
		$NavigationArea/Walls/Endwall.disabled = true
	else:
		$NavigationArea/Walls/Endwall.disabled = false
	
func spawn():

	var Spawned = enemy.instantiate()
	add_child(Spawned)
	Spawned.speed *= float(loop)/2
	Spawned.health += float(loop)/2
	Spawned.position = Vector2(randf_range(-2000, -200), randf_range(-1000, 1000))
	Spawned.time /= float(loop)/2
	Globals.amount += 1

func spawngun():
	var gun = gunenemy.instantiate()
	Globals.despawn = 7.5
	add_child(gun)
	gun.bullets = loop
	gun.cd /= loop
	gun.health += float(loop)/3
	gun.global_position = Vector2(randf_range(-2000, -200), randf_range(-1000, 1000))
	Globals.amount += 1
	

func _ready():
	$TileMapLayer2.show()
	$Player.global_position = $Spawntile.global_position
	spawn()
	Globals.despawn /= float(loop)/2


func _on_end_zone_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player") and Globals.amount == 0:
		$Player.global_position.x -= 4320
		loop += 1
		Globals.despawn = 15.0
		Globals.despawn /= float(loop)/2
		Globals.total += 1
		$TileMapLayer2.show()
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
				spawn()
