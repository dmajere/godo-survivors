extends Node2D

var green_eye: PackedScene = preload("res://scenes/enemies/green_eye.tscn")

func _on_human_attack_signal(weapon: PackedScene, pos: Vector2, dir:Vector2) -> void:
	var instance = weapon.instantiate() as Weapon
	instance.set_attack_position(pos, dir)
	instance.scale = Vector2(4, 4)
	$Projectiles.call_deferred("add_child", instance)


func _on_spawn_timer_timeout():
	var pos = get_random_offscreen_position()
	#left.y = randi_range(-distance.y, distance.y)
	var instance = green_eye.instantiate() as Monster
	instance.position = pos
	instance.scale = Vector2(3, 3)
	$Enemies.call_deferred("add_child", instance)

func get_random_offscreen_position() -> Vector2:
	var camera: Camera2D = $Human/Camera2D
	var screen_size = camera.get_window().size
	var center = $Human.position
	var offset = 30
	var left_side = center.x - screen_size.x / 2
	var right_side = center.x + screen_size.x / 2
	var top_side = center.y - screen_size.y / 2
	var bottom_side = center.y + screen_size.y / 2
	
	var left = [
		Vector2(
		left_side - offset, left_side - 10
		),
		Vector2(
			top_side - offset,
			bottom_side + offset
		)
	]
	var right = [
		Vector2(
			right_side + 10,
			right_side + offset
		),
		Vector2(
			top_side - offset,
			bottom_side + offset
		)
	]
	var top = [
		Vector2(
			left_side - offset,
			right_side + offset
		),
		Vector2(
			top_side - offset,
			top_side - 10
		)
	]
	var bottom = [
		Vector2(
			left_side - offset,
			right_side + offset
		),
		Vector2(
			bottom_side + 10,
			bottom_side + offset,
		)
	]
	var sides = [left, right, top, bottom]
	var range = sides[randi()%sides.size()]
	var x = range[0]
	var y = range[1]
	return Vector2(
		randi_range(x.x, x.y),
		randi_range(y.x, y.y)
	)

func _on_human_player_death():
	# GAME OVER
	get_tree().quit()
