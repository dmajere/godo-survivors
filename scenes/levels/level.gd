extends Node2D

@onready var spawn_points = $Enemies/SpawnPoints/Control
var green_eye: PackedScene = preload("res://scenes/enemies/green_eye.tscn")

func _on_human_attack_signal(weapon: PackedScene, pos: Vector2, dir:Vector2) -> void:
	var instance = weapon.instantiate() as Weapon
	instance.set_attack_position(pos, dir)
	instance.scale = Vector2(2, 2)
	$Projectiles.call_deferred("add_child", instance)


func _on_spawn_timer_timeout():
	var instance = green_eye.instantiate() as Monster
	instance.position = spawn_points.get_child(randi()%spawn_points.get_child_count()).global_position
	$Enemies.call_deferred("add_child", instance)
