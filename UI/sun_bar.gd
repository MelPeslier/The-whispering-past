extends TextureProgressBar

@onready var sun_particles: GPUParticles2D = $SunParticles

const U: float = 0.64
var t: float = 0.3

func _ready() -> void:
	Events.connect("add_sun", _on_add_sun)
	value = 0
	update_style_sun(value as float)

func _on_add_sun(val: int):
	update_style_sun(100.0)
	#update_style_diams()

func update_style_sun(val: float):
	var tween: Tween = get_tree().create_tween().set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_OUT).set_parallel()
	tween.tween_property(self, "value", val as int, t)
	tween.tween_property(self, "material:shader_parameter/val", val, t)
	
	tween.tween_property(sun_particles, "process_material:emission_box_extents", Vector3(val * U, 10.0, 1.0), t)
	tween.tween_property(sun_particles, "position", Vector2(128.0 - val * U, 16.0), t)
	sun_particles.set("amount", clamp(val, 1, 100))
	
	#set("material:shader_parameter/val", val)
#	sun_particles.process_material.set("emission_box_extents", Vector3(val * U, 10.0, 1.0))
#	sun_particles.set("position", Vector2(128.0 - val * U, 16.0))
