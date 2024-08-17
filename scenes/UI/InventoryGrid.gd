extends GridContainer

var ui_item = preload("res://scenes/UI/ui_item.tscn")
var inventory: Inventory


func _ready():
	inventory = Inventory.new()
	# generate few items
	for _i in 3:
		var item = Module.new()
		item.module_type = Module.ModuleType.values().pick_random()
		item.image = Module.ModuleIcons[item.module_type]
		inventory.add(item)

	inventory.sort("module_type")
	for item in inventory.items:
		_on_item_added(item, item.quantity, item.quantity)
	
	inventory.item_added.connect(_on_item_added)
	inventory.item_removed.connect(_on_item_removed)
	

func _on_item_added(item: Item, _qty: int, _total: int) -> void:
	var ui_icon = ui_item.instantiate() as UIItem 
	ui_icon.item = item
	add_child(ui_icon)
	
func _on_item_removed(item: Item, _qty: int, total: int) -> void:
	for ui_icon:UIItem in get_children():
		if ui_icon.item == item:
			if total == 0:
				remove_child(ui_icon)
			else:
				ui_icon._update()
