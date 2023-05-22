extends Sprite2D

func _ready() -> void:
	var tween: Tween = create_tween()
	tween.tween_property(self, "material:shader_parameter/dissolve_value", 0.0, 0.3)
	
