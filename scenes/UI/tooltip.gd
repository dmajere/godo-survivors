class_name Tooltip extends Control

var stat_scene: PackedScene = preload("res://scenes/UI/stat.tscn")

@onready var stats_vbox = %StatsVBoxContainer
@export var background_color: Color = Color("ffff30")
@export var status_label: String
@export var description: String
@export var power_requirement: int

var item: UIItem
var stats: Dictionary
	
func _ready():
	if item:
		var _item: Item = item.item
		background_color = Item.RARITY_COLORS[_item.rarity]
		if "equipped" in _item and _item.equipped:
			status_label = "Equipped"
		description = _item.description
		power_requirement = _item.power_requirement
		stats = _item.get_stats()
		
	%ItemBGRect.color = background_color
	%StatusLabel.text = status_label
	%DescriptionLabel.text = description
	%RequirementLabel.text = ("Power requirement: (%d)" % power_requirement)
	for key  in stats:
		var stat = stat_scene.instantiate() as Stat
		stat.stat_name = key
		stat.stat_value = stats[key]
		stats_vbox.add_child(stat)
