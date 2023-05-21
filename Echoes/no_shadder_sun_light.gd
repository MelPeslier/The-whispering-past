extends Area2D

@onready var chant: AudioStreamPlayer2D = $Chant
@onready var dissolution: AudioStreamPlayer2D = $Dissolution
@onready var particles_dissoulution: GPUParticles2D = $ParticlesDissoulution
@onready var collision_shape_2d: CollisionShape2D = $CollisionShape2D
@onready var sun_sprite: Sprite2D = $SunSprite
@onready var sun_sprite_2: Sprite2D = $SunSprite2
@onready var sun_sprite_3: Sprite2D = $SunSprite3

var type: Events.Type

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
	
	if tween:
		tween.kill()

func _on_area_entered(_area: Area2D) -> void:
	dissolution.play()
	collision_shape_2d.set_deferred("disabled", true)
	
	Events.emit_signal("add_point", type)
	
	particles_dissoulution.emitting = true
	
	var tween: Tween = get_tree().create_tween()
	
	tween.tween_property(self, "scale", Vector2(1.30, 1.30), 0.22)
	tween.parallel().tween_property(sun_sprite, "modulate:a", 0, 0.22)
	tween.parallel().tween_property(sun_sprite_2, "modulate:a", 0, 0.24)
	tween.parallel().tween_property(sun_sprite_3, "modulate:a", 0, 0.26)
	
	await get_tree().create_timer(5.0).timeout
	queue_free()



