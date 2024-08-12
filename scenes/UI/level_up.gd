extends Control

class Option:
	var texture: CompressedTexture2D
	var tooltip: String
	var callback: Callable
	
	func _init(image: CompressedTexture2D, ttip: String, cb: Callable) -> void:
		self.texture = image
		self.tooltip = ttip
		self.callback = cb

signal closed

func _ready():
	visible = false
	
func open():
	visible = true

func close() -> void:
	for ch in $PanelContainer/HBoxContainer.get_children():
		ch.queue_free()
	visible=false
	closed.emit()

# texture, tooltip, callback
func configure(options: Array) -> void:
	var i = 0
	
	for option: Option in options:
		var button = TextureButton.new()
		button.stretch_mode = TextureButton.STRETCH_KEEP_CENTERED
		button.texture_normal = option.texture
		button.tooltip_text = option.tooltip
		button.pressed.connect(
			func():
				option.callback.call_deferred()
				close()
		)
		$PanelContainer/HBoxContainer.add_child(button)
		
		# TODO: should we allow more than 3 options?
		# how layout should transform in this case?
		i += 1
		if i == 3:
			break
