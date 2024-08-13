extends Weapon

@onready var targets: Array[CharacterBody2D] = []

func _ready():
	super()
	projectile = load("res://scenes/projectiles/arrow.tscn")
	
func get_target_direction() -> Vector2:
	# TODO: doesnt work.
	# we need a proper min heap sorting by length
	# adding on enter signal
	# removing on exit signal
	# need C#
	for zone: Area2D in $Visibility.get_children():
		
		var targets = zone.get_overlapping_bodies()
		print(zone, targets)
		if targets:
			return pick_closest_target(targets)
	return Vector2.ZERO

func pick_closest_target(targets) -> Vector2:
	var pick = targets[0]
	var distance = (pick.position - Globals.player_position).length()
	for target in targets:
		if "is_player" in target:
			print("player")
			continue
		var test = (target.position - Globals.player_position).length()
		if test < distance:
			distance = test
			pick = target
	return (pick.position - Globals.player_position).normalized()
