class_name Item extends Resource

@export var name: String = "Item Name"
@export var description: String
@export var image: Texture2D
@export var quantity: int = 1
@export var stackable: bool = false
@export var rarity: Rarity = Rarity.Common
@export var tier: Tier = Tier.Normal
@export var power_requirement: int = 1
@export var inventory: Inventory
@export var category: Category = Category.Module

enum Rarity {
	Common,
	Rare,
	Legendary,
	Unique
}

enum Tier {
	Broken,
	Normal,
}

enum Category {
	Module,
	Ammo, # NotImplemented
	Armor, # NotImplemented
}

static var RARITY_COLORS: Array[Color] = [
	Color(.3, .3, .3, 1),
	Color(.18, .23, .63, 1),
	Color(.58, .5, .0, 1),
	Color(.56, .21, .0, 1),
	Color(.54, .34, .12, 1),
]

func get_stats() -> Dictionary:
	return {}
