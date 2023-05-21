extends TextureProgressBar

@onready var particles: GPUParticles2D = $Particles

const U: float = 0.64
var t: float = 0.22

var _type: Events.Type = Events.Type.MOON

func _ready() -> void:
	Events.connect("add_to_bar", _on_add_to_bar)
	value = 0
	particles.emitting = false
	set("material:shader_parameter/type", _type)

func _on_add_to_bar(type: Events.Type, val: float) -> void:
	if type == _type:
		if val > 0:
			if not particles.emitting:
				particles.emitting = true
			particles.set("amount", val as int)
			Events.emit_signal("add_diam", type, val)
		else:
			particles.emitting = false
		
		var tween: Tween = get_tree().create_tween().set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_OUT).set_parallel()
		tween.tween_property(self, "value", val as int, t)
		tween.tween_property(self, "material:shader_parameter/val", val as float, t)
		
		tween.tween_property(particles, "process_material:emission_box_extents", Vector3(val * U, 10.0, 1.0), t)
		tween.tween_property(particles, "position", Vector2(128.0 - val * U, 16.0), t)
	
#	set("material:shader_parameter/val", val)
#	moon_particles.process_material.set("emission_box_extents", Vector3(val * U, 10.0, 1.0))
#	moon_particles.set("position", Vector2(128.0 - val * U, 16.0))
#	moon_particles.set("amount", clamp(val, 1, 100))
