extends Area2D

@onready var collision_shape_2d: CollisionShape2D = $CollisionShape2D

func _on_area_entered(_area: Area2D) -> void:
	collision_shape_2d.set_deferred("disabled", true)
	
	Events.emit_signal("cut_scene")
