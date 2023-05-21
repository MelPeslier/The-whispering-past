extends TextureProgressBar

@onready var moon_particles: GPUParticles2D = $MoonParticles

func _ready() -> void:
	Events.connect("add_moon", _on_add_moon)

func _on_add_moon(val: int):
	value = val
	if val > 0:
		update_style()

func update_style():
	pass
