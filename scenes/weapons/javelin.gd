extends Weapon

func _ready():
	DAMAGE = 10
	ATTACK_RATE = 10
	ATTACK_DURATION = 1.5
	PIERCE = 1


func set_attack_position(pos: Vector2, dir: Vector2) -> void:
	direction = dir
	position = pos + dir * $Image.texture.get_size() * 2
	rotation = dir.angle()

func move(delta) -> void:
	position += direction * PROJECTILE_MOVE_SPEED * delta
