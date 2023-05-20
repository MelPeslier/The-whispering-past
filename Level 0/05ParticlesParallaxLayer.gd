extends ParallaxLayer

func _ready() -> void:
	var _color1 = Color(0.85490196943283, 0.66666668653488, 0)
	var _color2: Color = Color(0, 0.64705884456635, 0.52549022436142)
	var tween: Tween = get_tree().create_tween().set_loops()
	tween.set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN_OUT)
	tween.tween_property(self, "modulate", _color1, 5.0)
	tween.tween_property(self, "modulate", _color2, 7.5)
