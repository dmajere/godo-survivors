extends Area2D
class_name AreaProjectile

@export var DAMAGE: int;
@export var PIERCE: int;
@export var SPEED: int;
@export var DURATION: float;
var direction: Vector2;

func _ready():
	$TTL.wait_time = DURATION
	$TTL.start()

func _process(delta):
	move(delta)

func move(delta):
	position += direction * SPEED * delta

func _on_body_entered(body):
	if "hit" in body:
		on_hit()
		if body.hit(DAMAGE):
			PIERCE -= 1
		
	if PIERCE == 0:
		on_stop()
		queue_free()

func _on_ttl_timeout():
	queue_free()

func on_hit():
	pass

func on_stop():
	pass
