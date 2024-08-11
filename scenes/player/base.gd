extends CharacterBody2D
class_name Player

signal attack_signal(weapon: PackedScene, position, direction)

@export var BASE_SPEED: int;
@export var BASE_ATTACK_RATE: int;
@export var BASE_WEAPON: PackedScene;
var SPEED: int;
var ATTACK_RATE: int;
var WEAPONS: Array;
var ACTIVE_WEAPON: PackedScene;

func _ready():
	SPEED = BASE_SPEED
	
	if BASE_WEAPON:
		init_weapon(BASE_WEAPON)
		

class AttackCooldownTimer extends Timer:
	var weapon: PackedScene;
	
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
	
	#for timer: Timer in $AttackTimers.get_children():
		#print("Timer ", timer, timer.is_stopped())

func get_attack_direction() -> Vector2:
	return (get_global_mouse_position() - global_position).normalized()
	
func attack(weapon: PackedScene) -> void:
	var direction = get_attack_direction()
	attack_signal.emit(weapon, global_position, direction)
