extends HBoxContainer

@onready var name_label: Label = %Name
@onready var value_label: Label = %Value
@onready var icon_box: TextureRect = %Icon


@export var stat_name: String = "Stat":
	set(value):
		stat_name = value
		_update_labels()
		
@export var stat_value: int = 10:
	set(value):
		stat_value = value
		_update_labels()

@export var stat_icon: Texture2D:
	set(value):
		stat_icon = value
		_update_labels()

func _ready():
	_update_labels()

func _update_labels():
	if name_label:
		name_label.text = stat_name
	if value_label:
		value_label.text = str(stat_value)
	if icon_box:
		icon_box.texture=  stat_icon
