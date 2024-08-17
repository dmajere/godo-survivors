class_name Inventory extends Resource

signal item_added(item, qty, total)
signal item_removed(item, qty, total)

@export var max_capacity: int = 1
@export var items: Array[Item]

func _init(cap: int=1):
	max_capacity = cap
	
func find(item: Item) -> Item:
	var res = items.find(item)
	return items[res] if res >= 0 else null

func add(item: Item, qty: int = 1) -> void:
	var i = find(item)
	
	if !i:
		items.append(item)
		item.inventory = self
		i = item
		i.quantity = qty
		item_added.emit(i, qty, i.quantity)
	else:
		i.quantity += qty
		item_added.emit(i, qty, i.quantity)

func remove(item: Item, qty: int = 1) -> void:
	var i = find(item)
	if !i:
		return
	i.quantity -= min(qty, i.quantity)
	item_removed.emit(i, qty, i.quantity)
	if i.quantity == 0:
		items.erase(item)

func has(item: Item, qty: int = 1) -> bool:
	return count(item) >= qty
	

func count(item: Item) -> int:
	var i = find(item)
	if i:
		return i.quantity
	return 0

func sort(prop: String):
	items.sort_custom(
		func(a: Item, b: Item):
			var _a = a.get(prop)
			var _b = b.get(prop)
			return _a <= _b	
	)
