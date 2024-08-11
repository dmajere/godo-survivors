extends Node2D


func _on_human_attack_signal(weapon: PackedScene, pos: Vector2, dir:Vector2) -> void:
	var instance = weapon.instantiate() as Weapon
	instance.set_attack_position(pos, dir)
	$Projectiles.call_deferred("add_child", instance)

