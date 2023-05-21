extends TextureProgressBar

@onready var moon_particles: GPUParticles2D = $MoonParticles

const U: float = 0.64

func _ready() -> void:
	Events.connect("add_moon", _on_add_moon)
	value = 100
	update_style_moon(value as float)

func _on_add_moon(val: int):
	value = val
	update_style_moon(value as float)
	if value > 0:
#		update_style_diams()
		pass

func update_style_moon(val: float):
	# Partie shader pourla couleur de la progress bar
	set("material:shader_parameter/val", val)
	
	# Partie Particules
	moon_particles.process_material.set("emission_box_extents", Vector3(val * U, 10.0, 1.0))
	moon_particles.set("position", Vector2(128.0 - val * U, 16.0))
	moon_particles.set("amount", val)
