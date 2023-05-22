extends CanvasLayer

@onready var audio_stream_player: AudioStreamPlayer = $AudioStreamPlayer

@onready var sprite_2d: Sprite2D = $Sprite2D

func _ready() -> void:
	visible = true
	await get_tree().create_timer(1).timeout
	audio_stream_player.play()
	var t: Tween = create_tween().set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN_OUT)
	t.tween_property(sprite_2d, "material:shader_parameter/dissolve_value", 0.0, 3.0)
	
	await get_tree().create_timer(9.5).timeout
	if t:
		t.kill()
	visible = false
	Events.emit_signal("start_game")
	queue_free()
	
