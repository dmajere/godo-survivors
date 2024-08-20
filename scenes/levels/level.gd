extends Node2D



var item: PackedScene = preload("res://scenes/items/base.tscn")
var green_eye: PackedScene = preload("res://scenes/enemies/green_eye.tscn")

var speed_icon = load("res://graphics/gui/abilities/jump.png")
var health_icon = load("res://graphics/gui/invocations/elyvilon_heal_other.png")
var knockback_icon = load("res://graphics/gui/skills/fighting.png")
var exp_rate_icon = load("res://graphics/gui/abilities/shaft_self.png")
var damage_icon = load("res://graphics/gui/skills/axes.png")
@export var EXP_SHARD_DROP_CHANCE: int = 10

@onready var player = $Moving/Human
@onready var inventory = $Moving/Human/Inventory
@onready var enemies = $Moving/Enemies
@onready var projectiles = $Moving/Projectiles
@onready var level_up_menu = $InGameMenu/LevelUpMenu
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
	Option.new(
		exp_rate_icon,
		"increase exp rate",
		func(): player.add_item(Globals.ItemType.EXP_RATE_INC)
	),
	Option.new(
		damage_icon,
		"increase damage",
		func(): player.add_item(Globals.ItemType.DAMAGE_INC)
	),
]

func roll_dice(max_chance: int) -> int:
	return randi()%max_chance
	
func spawn_experience(pos: Vector2):
	var res = roll_dice(100)
	if res <= EXP_SHARD_DROP_CHANCE:
		var instance = item.instantiate() as Drop
		instance.item_type = Globals.ItemType.EXP_SMALL
		if res <= EXP_SHARD_DROP_CHANCE / 10.0:
			instance.item_type = Globals.ItemType.EXP_BIG
		instance.position = pos
		$Items.call_deferred("add_child", instance)

func _on_spawn_timer_timeout():
	var pos = get_random_offscreen_position()
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
	var value_range = sides[randi()%sides.size()]
	var x = value_range[0]
	var y = value_range[1]
	return Vector2(
		randi_range(x.x, x.y),
		randi_range(y.x, y.y)
	)

func _on_human_player_death():
	# GAME OVER
	get_tree().quit()

func _on_human_player_level():
	var options = []
	for _i in 3:
		options.append(level_up_options[randi()%level_up_options.size()])
	level_up_menu.configure(options)
	level_up_menu.open()
	$Moving.get_tree().paused = true

func _on_level_up_menu_closed():
	$Moving.get_tree().paused = false

func _on_human_player_attack(projectile: Node2D):
	projectiles.call_deferred("add_child", projectile)

func _on_human_player_add_weapon(icon: Texture2D):
	$InGameMenu/WeaponList.append(icon)
