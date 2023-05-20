extends Camera2D

@onready var ambiant: AudioStreamPlayer2D = $Ambiant

func _ready() -> void:
	ambiant.play()
