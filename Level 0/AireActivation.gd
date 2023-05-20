extends Area2D

func _on_area_entered(area: Area2D) -> void:
	if area.is_in_group("SpawnPoint"):
		if randf() < 0.5:
			Events.emit_signal("spawn", Events.Type.MOON, self.global_position)
		else:
			Events.emit_signal("spawn", Events.Type.SUN, self.global_position)
