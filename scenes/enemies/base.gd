extends CharacterBody2D
class_name Monster

signal enemy_died(pos: Vector2)

@export var HEALTH: int;
@export var SPEED: int;
@export var ATTACK_RATE: int;
@export var DAMAGE: int;

func move(delta):
	var direction = (Globals.player_position - position).normalized()
	velocity = direction * SPEED * delta * 1000
	move_and_slide()
	
func _process(delta):
	move(delta)
	
func hit(damage: int) -> bool:
	if $Timers/Invulnarability.is_stopped():
		$Timers/Invulnarability.start()
		HEALTH -= damage
		if HEALTH <= 0:
			enemy_died.emit(global_position)
			queue_free() 
		return true
	return false
		
func _on_attack_area_body_entered(body):
	# We use separate Area2d node for player hit detection
	# since its easier than detecting Char to Char collision
	if "is_player" in body:
		body.hit(DAMAGE)
		var direction = (position - body.position).normalized()
		position += direction * body.KNOCKBACK

