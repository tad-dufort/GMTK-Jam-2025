extends Node2D


@onready var pos = global_position

func _ready() -> void:
	$despawn.set_wait_time(Globals.despawn)
	$despawn.start()


func _process(delta: float) -> void:
	if $despawn.is_stopped():
		queue_free()
	global_position = pos


func _on_particlearea_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		queue_free()
