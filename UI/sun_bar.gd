extends TextureProgressBar

func _ready() -> void:
	Events.connect("add_sun", _on_add_sun)

func _on_add_sun(val: int):
	value = val
