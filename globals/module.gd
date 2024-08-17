class_name Module extends Item


@export var equipped: bool = false
@export var module_type: ModuleType


enum ModuleType {
	Amplifier,
	Splitter,
	Focus,
}

static var ModuleIcons: Dictionary = {
	ModuleType.Amplifier: preload("res://graphics/gui/skills/evocations.png"),
	ModuleType.Splitter: preload("res://graphics/gui/skills/ice_magic.png"),
	ModuleType.Focus: preload("res://graphics/gui/skills/air_magic.png"),
}

# NotImplemented
var upgrades: int = 0
var max_upgrades: int = 0

# NotImplemented
var durability: int = 100
var max_durability: int = 100

var min_ranges: Dictionary = {
	Tier.Broken: 0,
	Tier.Normal: 10,
}

var max_ranges: Dictionary = {
	Tier.Broken: 15,
	Tier.Normal: 40,
}

func _get_max_upgrades(tier: Tier, rarity: Rarity):
	match(tier):
		Tier.Broken:
			return 0
		Tier.Normal:
			match(rarity):
				Rarity.Common:
					return 1
				Rarity.Rare:
					return 2
				Rarity.Legendary:
					return 3
				Rarity.Unique:
					return 4
