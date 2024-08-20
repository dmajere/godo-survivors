extends Weapon

@onready var targets = {}

func _ready():
	super()
	projectile = load("res://scenes/projectiles/arrow.tscn")
	
func get_target_direction() -> Vector2:
	if targets:
		return pick_closest_target()
	return Vector2.ZERO

func pick_closest_target() -> Vector2:
	var target_list = targets.keys()
	var pick = target_list[0]
	var distance = (pick.position - Globals.player_position).length()
	for target in target_list:
		if "is_player" in target:
			print("player")
			continue
		var test = (target.position - Globals.player_position).length()
		if test < distance:
			distance = test
			pick = target
	return (pick.position - Globals.player_position).normalized()


func _on_visibility_body_entered(body: Monster):
	targets[body] = true

func _on_visibility_body_exited(body: Monster):
	targets.erase(body)
