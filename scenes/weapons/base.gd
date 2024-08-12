extends Area2D
class_name Weapon

enum WEAPON_TYPE {MELLE, RANGE}

@export var DAMAGE: int;
@export var ATTACK_RATE: int;
@export var ATTACK_DURATION: float;
@export var TYPE: WEAPON_TYPE;
@export var PIERCE: int;
@export var PROJECTILE_MOVE_SPEED: int;

var direction: Vector2 = Vector2.ZERO;

func _ready():
	$TTL.wait_time = ATTACK_DURATION
	$TTL.start()
	
func _process(delta):
	if TYPE == WEAPON_TYPE.RANGE:
		position += direction * PROJECTILE_MOVE_SPEED * delta
	
func _on_ttl_timeout():
	queue_free()

func _on_body_entered(body):	
	if "hit" in body:
		if body.hit(DAMAGE):
			PIERCE -= 1
		
	if PIERCE == 0:
		queue_free()

func get_texture_size() -> Vector2:
	return $Image.texture.get_size()
	
func set_attack_position(_pos: Vector2, _dir: Vector2) -> void:
	pass
	
