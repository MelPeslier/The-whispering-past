extends ParallaxLayer

@export var speed: float

func _process(delta: float) -> void:
	self.motion_offset.x += speed * delta
