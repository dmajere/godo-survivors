class_name UIItem extends Control
	
@export var item: Item:
	set(_item):
		item = _item

@onready var image = %ItemTexture
@onready var icon = %ItemIconTexture
var hovered: bool = false

func _ready():
	_update()
	
func _update():
	if item:
		image.texture = item.image
		if item.quantity > 1:
			%QuantityLabel.text = str(item.quantity)
			%QuantityLabel.visible = true
	
	if !mouse_entered.is_connected(InventoryUI.on_hover_item.bind(self)):
		mouse_entered.connect(InventoryUI.on_hover_item.bind(self))
	if !mouse_exited.is_connected(InventoryUI.on_hover_leave.bind(self)):
		mouse_exited.connect(InventoryUI.on_hover_leave.bind(self))
	
