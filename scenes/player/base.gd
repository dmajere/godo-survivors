extends CharacterBody2D
class_name Player

var is_player: bool = true
signal attack_signal(weapon: PackedScene, position, direction)
signal player_death

@export var BASE_SPEED: int;
@export var BASE_ATTACK_RATE: int;
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
@onready var EXP_TO_NEXT_LEVEL: int = 100

class AttackCooldownTimer extends Timer:
	var weapon: PackedScene;
	
func _ready():
	SPEED = BASE_SPEED
	KNOCKBACK = BASE_KNOCKBACK
	HEALTH = BASE_HEALTH
	EXP_RATE = BASE_EXP_RATE
	Globals.player_position = global_position
	
	if BASE_WEAPON:
		init_weapon(BASE_WEAPON)
		
func init_weapon(weapon: PackedScene) -> void:
	WEAPONS.append(weapon)
	
	var _instance: Weapon = weapon.instantiate()
	var timer = AttackCooldownTimer.new()
	timer.weapon = weapon
	timer.wait_time = 10.0 / _instance.ATTACK_RATE
	timer.autostart = true
	timer.timeout.connect(func(): attack(weapon))
	$AttackTimers.add_child(timer)
	_instance.queue_free()
			
func _process(delta):
	var direction: Vector2 = Input.get_vector("move_left", "move_right", "move_up", "move_down")
	velocity = direction * SPEED * delta * 1000
	move_and_slide()
	Globals.player_position = global_position

func get_attack_direction() -> Vector2:
	return (get_global_mouse_position() - global_position).normalized()
	
func attack(weapon: PackedScene) -> void:
	var direction = get_attack_direction()
	attack_signal.emit(weapon, global_position, direction)

func hit(_damage: int) -> void:
	if $Invulnerability.is_stopped():
		HEALTH -= _damage
		if HEALTH <= 0:
			player_death.emit()

func add_item(item_type: Globals.ItemType) -> void:
	if item_type == Globals.ItemType.EXP_SMALL:
		Experience += 10 * EXP_RATE
		if Experience >= EXP_TO_NEXT_LEVEL:
			level_up()
			
func level_up():
	# pick rand 3 bonuses
	# draw UI
	# wait input
	# apply bonus
	# recal next level
	pass
