extends Node2D
class_name Weapon

signal shoot_projectile(projectile: Node2D)
var CooldownBase: float = 10.0

@export var DAMAGE: int;
@export var RATE: float;
@export var DURATION: float;
@export var PIERCE: int;
@export var PROJECTILE_SPEED: int;
@onready var projectile: PackedScene;

func _ready() -> void:
	$Cooldown.wait_time = CooldownBase / RATE
	$Cooldown.start()
	print($Cooldown.wait_time)

func _on_cooldown_timeout() -> void:
	shoot_projectile.emit(make_projectile())

func make_projectile() -> Node2D:
	var instance = projectile.instantiate()
	# Basic parameters
	instance.DURATION = DURATION
	instance.DAMAGE = DAMAGE
	instance.PIERCE = PIERCE
	instance.SPEED = PROJECTILE_SPEED
	
	# Movement parameters
	var direction = get_target_direction()

	instance.direction = direction
	instance.position = Globals.player_position + get_projectile_offset(direction)
	instance.rotation = direction.angle()
		
	return instance

func get_target_direction() -> Vector2:
	return Vector2.ZERO
	
func get_projectile_offset(_direction: Vector2) -> Vector2:
	return Vector2.ZERO

func set_rate(value: float) -> void:
	RATE = value
	$Cooldown.wait_time = CooldownBase / RATE

func get_icon() -> Texture2D:
	return $Icon.texture
