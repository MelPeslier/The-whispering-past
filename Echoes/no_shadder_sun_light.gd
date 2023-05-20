extends Area2D

@onready var chant: AudioStreamPlayer2D = $Chant

func _ready() -> void:
	chant.play()
	
	var time_up = randf_range(0.75, 1.25)
	var time_down = time_up * randf_range(1.25, 1.45)
	
	var tween: Tween = get_tree().create_tween().set_loops()
	tween.set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN_OUT)
	
	tween.tween_property(self, "scale", Vector2(1.15, 1.15), time_up)
	tween.parallel().tween_property(self, "position:y", position.y - 20.0, time_up)

	tween.tween_property(self, "scale", Vector2(0.85, 0.85), time_down)
	tween.parallel().tween_property(self, "position:y", position.y + 1.0, time_down)
