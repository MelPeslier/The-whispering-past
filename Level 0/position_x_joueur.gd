extends Marker2D

@onready var player: CharacterBody2D = $"../Player"

func _physics_process(_delta: float) -> void:
	position.x  = player.position.x
