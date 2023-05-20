extends ParallaxLayer

func _ready() -> void:
	var alpha: float = 0.2
	modulate.a = alpha
	var tween: Tween = get_tree().create_tween().set_loops()
	tween.set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN_OUT)
	tween.tween_property(self, "modulate:a", 0.7, 35.0)
	tween.tween_property(self, "modulate:a", alpha, 45.0)
