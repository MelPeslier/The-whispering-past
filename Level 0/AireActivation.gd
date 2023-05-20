extends Area2D

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("SpawnPoint"):
		if randf() < 0.5:
			Events.emit_signal("spawn", Events.Type.MOON)
		else:
			Events.emit_signal("spawn", Events.Type.SUN)
