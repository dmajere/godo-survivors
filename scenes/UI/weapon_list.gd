extends Control
#TODO:
# make configurable: allow to init with number of rows and cols
# allow extend number of rows, cols?

@onready var total_slots = 6;
@onready var current_slot = 0;
var rows = 2
var cols = 3

func append(image: Texture2D):
	if current_slot < total_slots - 1:
		var col = current_slot % rows
		var row = current_slot % cols
		
		var V = $Container/HBox.get_child(col + 1)
		var panel = V.get_child(row + 1)
		var texture_rect = TextureRect.new()
		texture_rect.texture = image
		texture_rect.stretch_mode = TextureRect.STRETCH_KEEP
		panel.add_child(texture_rect)
		
		current_slot += 1
