extends Area2D
class_name Item

@export var item_type: Globals.ItemType;

# There is not much logic inside items. 
# It seems that how item affects player should be deffined in player.
# so, it seems there is no need for many subclusses. for now.

func _on_body_entered(body) -> void:
	body.add_item(item_type)
	queue_free()
