extends Node2D



var item: PackedScene = preload("res://scenes/items/base.tscn")
var green_eye: PackedScene = preload("res://scenes/enemies/green_eye.tscn")

var speed_icon = load("res://graphics/gui/abilities/jump.png")
var health_icon = load("res://graphics/gui/invocations/elyvilon_heal_other.png")
var knockback_icon = load("res://graphics/gui/skills/fighting.png")

@onready var player = $Moving/Human
@onready var enemies = $Moving/Enemies
@onready var projectiles = $Moving/Projectiles
@onready var level_up_menu = $PopUpMenu/LevelUpMenu
@onready var Option = level_up_menu.Option
@onready var level_up_options: Array = [
	Option.new(
		speed_icon,
		"increase_speed",
		func(): player.add_item(Globals.ItemType.SPEED_INC)
	),
	Option.new(
		health_icon,
		"increase health",
		func(): player.add_item(Globals.ItemType.HEALTH_INC)
	),
	Option.new(
		knockback_icon,
		"increase knockback",
		func(): player.add_item(Globals.ItemType.KNOCKBACK_INC)
	),
]

func _ready():
	pass
	# _init_base_level_up_options()

	
func _on_human_attack_signal(weapon: PackedScene, pos: Vector2, dir:Vector2) -> void:
	var instance = weapon.instantiate() as Weapon
	instance.set_attack_position(pos, dir)
	instance.scale = Vector2(4, 4)
	projectiles.call_deferred("add_child", instance)

func spawn_experience(pos: Vector2):
	# TODO: random drop probability
	# TODO: rare big exp drop
	var instance = item.instantiate() as Item
	instance.item_type = Globals.ItemType.EXP_SMALL
	instance.position = pos
	$Items.call_deferred("add_child", instance)

func _on_spawn_timer_timeout():
	var pos = get_random_offscreen_position()
	#left.y = randi_range(-distance.y, distance.y)
	var instance = green_eye.instantiate() as Monster
	instance.position = pos
	instance.scale = Vector2(3, 3)
	instance.enemy_died.connect(spawn_experience)
	enemies.call_deferred("add_child", instance)

func get_random_offscreen_position() -> Vector2:
	var camera: Camera2D = player.get_camera()
	var screen_size = camera.get_window().size
	var center = player.position
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

func _on_human_player_level():
	#TODO: select 3 random options
	var options = level_up_options
	level_up_menu.configure(options)
	level_up_menu.open()
	$Moving.get_tree().paused = true

func _on_level_up_menu_closed():
	$Moving.get_tree().paused = false
