extends ParallaxLayer

func _ready() -> void:
	var _color1 = Color(0.27843138575554, 1, 0.2549019753933)
	var _color2: Color = Color(0.86274510622025, 0.90196079015732, 0.20784313976765)
	var tween: Tween = get_tree().create_tween().set_loops()
	tween.set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN_OUT)
	tween.tween_property(self, "modulate", _color1, 5.0)
	tween.tween_property(self, "modulate", _color2, 7.5)
