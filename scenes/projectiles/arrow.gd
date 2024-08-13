extends AreaProjectile

func _ready():
	if direction == Vector2.ZERO:
		queue_free()
	super()
