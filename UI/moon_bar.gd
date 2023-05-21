extends TextureProgressBar

@onready var moon_particles: GPUParticles2D = $MoonParticles

const U: float = 0.64

var t: float = 0.22

func _ready() -> void:
	Events.connect("add_moon", _on_add_moon)
	value = 0
	update_style_moon(value as float)

func _on_add_moon(val: int):
	update_style_moon(val as float)
	#update_style_diams()

func update_style_moon(val: float):
	var tween: Tween = get_tree().create_tween().set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_OUT).set_parallel()
	tween.tween_property(self, "value", val as int, t)
	tween.tween_property(self, "material:shader_parameter/val", val, t)
	
	tween.tween_property(moon_particles, "process_material:emission_box_extents", Vector3(val * U, 10.0, 1.0), t)
	tween.tween_property(moon_particles, "position", Vector2(128.0 - val * U, 16.0), t)
	moon_particles.set("amount", clamp(val, 1, 100))
#	set("material:shader_parameter/val", val)
#	moon_particles.process_material.set("emission_box_extents", Vector3(val * U, 10.0, 1.0))
#	moon_particles.set("position", Vector2(128.0 - val * U, 16.0))
#	moon_particles.set("amount", clamp(val, 1, 100))
