extends Weapon

func set_attack_position(pos: Vector2, dir: Vector2) -> void:
	direction = dir
	position = pos + dir * get_texture_size() * 2
	rotation = dir.angle()
