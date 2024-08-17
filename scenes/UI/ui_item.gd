class_name UIItem extends Control

@export var item: Item:
	set(_item):
		item = _item

@onready var texture = %ItemTexture
@onready var icon = %ItemIconTexture

func _ready():
	_update()
	
func _update():
	if item:
		icon.texture = item.image
