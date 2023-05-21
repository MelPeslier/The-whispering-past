extends TextureProgressBar

@onready var particles: GPUParticles2D = $Particles

const U: float = 0.64
var t: float = 0.7

var sun_color: Color = Color(1, 0.83137255907059, 0.40784314274788)
var moon_color: Color = Color(0.27843138575554, 0.0274509806186, 0.51764708757401)

func _ready() -> void:
	Events.connect("add_diam", _on_add_diam)
	value = 0
	particles.emitting = false

func _on_add_diam(type: Events.Type, val: int) -> void:
	set("material:shader_parameter/type", type)
	var actual_color: Color
	if type == Events.Type.MOON:
		actual_color = moon_color
	else:
		actual_color = sun_color
	
	if not particles.emitting:
		particles.amount = val
		particles.emitting = true
	else:
		particles.emitting = false
	
	var tween: Tween = get_tree().create_tween().set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_OUT).set_parallel()
	tween.tween_property(self, "self_modulate", actual_color, t)
	tween.tween_property(particles, "process_material:color", actual_color, t)
	
#	set("material:shader_parameter/val", val)
#	moon_particles.process_material.set("emission_box_extents", Vector3(val * U, 10.0, 1.0))
#	moon_particles.set("position", Vector2(128.0 - val * U, 16.0))
#	moon_particles.set("amount", clamp(val, 1, 100))

