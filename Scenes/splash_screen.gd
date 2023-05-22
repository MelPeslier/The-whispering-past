extends Control

@onready var audio_stream_player_2d: AudioStreamPlayer2D = $AudioStreamPlayer2D

func _ready() -> void:
	audio_stream_player_2d.play()

func _on_play_button_pressed() -> void:
	var t: Tween = create_tween().set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN_OUT)
	
	t.tween_property(audio_stream_player_2d, "volume_db", -40, 0.3)
	get_tree().change_scene_to_file("res://Level 0/level_0.tscn")
