class_name InventoryUI extends Control

var tooltip: Tooltip
var tooltip_scene: PackedScene = preload("res://scenes/UI/tooltip.tscn")
static var _ui: InventoryUI

func _ready():
	_ui = self if !_ui else _ui

static func on_hover_item(item: UIItem) -> void:
	item.hovered = true
	if _ui:
		_ui.delete_tooltip()
		var tt: Tooltip = _ui.tooltip_scene.instantiate() as Tooltip
		tt.item = item
		_ui.tooltip = tt
		tt.global_position.x = item.global_position.x - tt.size.x - 40
		tt.global_position.y = item.global_position.y - tt.size.y - 10
		_ui.add_child(tt)

static func on_hover_leave(item: UIItem) -> void:
	item.hovered = false
	if _ui:
		_ui.delete_tooltip()
		
func delete_tooltip() -> void:
	if _ui.tooltip and !_ui.tooltip.is_queued_for_deletion():
		_ui.remove_child(_ui.tooltip)
		if _ui.tooltip.mouse_entered.is_connected(_ui.on_hover_item):
			_ui.tooltip.mouse_entered.disconnect(_ui.on_hover_item)
		if _ui.tooltip.mouse_exited.is_connected(_ui.on_hover_leave):
			_ui.tooltip.mouse_exited.disconnect(_ui.on_hover_leave)
		_ui.tooltip.queue_free()
		_ui.tooltip = null
