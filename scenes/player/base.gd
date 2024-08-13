extends CharacterBody2D
class_name Player

var is_player: bool = true
signal player_death
signal player_level
signal player_attack(projectile: Node2D)
signal player_add_weapon(icon)

@export var BASE_SPEED: int;
@export var BASE_WEAPON: PackedScene;
@export var BASE_KNOCKBACK: int = 50;
@export var BASE_HEALTH: int = 100;
@export var BASE_EXP_RATE: int = 1;

var SPEED: int;
var HEALTH: int;
var KNOCKBACK: int;
var WEAPONS: Array;
var EXP_RATE: int;
@onready var Experience: int = 0
@onready var EXP_TO_NEXT_LEVEL: int = 10

class AttackCooldownTimer extends Timer:
	var weapon: PackedScene;
	
func _ready():
	SPEED = BASE_SPEED
	KNOCKBACK = BASE_KNOCKBACK
	HEALTH = BASE_HEALTH
	EXP_RATE = BASE_EXP_RATE
	Globals.player_position = global_position
	
	if BASE_WEAPON:
		add_weapon(BASE_WEAPON)
		
func add_weapon(weapon: PackedScene) -> void:
	var instance = weapon.instantiate() as Weapon
	#instance.visible = false
	instance.shoot_projectile.connect(func(p): player_attack.emit(p))
	$Inventory.call_deferred("add_child", instance)
	player_add_weapon.emit(instance.get_icon())
	
func _process(delta):
	var direction: Vector2 = Input.get_vector("move_left", "move_right", "move_up", "move_down")
	velocity = direction * SPEED * delta * 1000
	move_and_slide()
	Globals.player_position = global_position

func hit(_damage: int) -> void:
	if $Invulnerability.is_stopped():
		HEALTH -= _damage
		if HEALTH <= 0:
			player_death.emit()

func add_item(item_type: Globals.ItemType) -> void:
	# TODO: add other item types
	if item_type == Globals.ItemType.SPEED_INC:
		SPEED += 10
	elif item_type == Globals.ItemType.HEALTH_INC:
		HEALTH += 10
	elif item_type == Globals.ItemType.KNOCKBACK_INC:
		KNOCKBACK += 10
	elif item_type == Globals.ItemType.EXP_SMALL:
		Experience += 10 * EXP_RATE
		if Experience >= EXP_TO_NEXT_LEVEL:
			player_level.emit()
			# TODO: increase next level cap

func get_camera() -> Camera2D:
	return $Camera2D
