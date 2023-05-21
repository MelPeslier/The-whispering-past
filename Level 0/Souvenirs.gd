extends Node2D

@onready var moon: PackedScene = preload("res://Echoes/moon.tscn")
@onready var sun: PackedScene = preload("res://Echoes/sun.tscn")

func _ready() -> void:
	Events.connect("spawn", on_spawn)

func on_spawn(type: Events.Type, _pos: Vector2):
	var item:PackedScene
	
	match type:
		Events.Type.MOON:
			item = moon
		Events.Type.SUN:
			item = sun
	
	var obj = item.instantiate()
	
	var pos: Vector2 = Vector2(_pos.x + randf_range(-30.0, 30.0), _pos.y + randf_range(-150.0, 150.0))
	obj.global_position = pos
	
	obj.type = type
	
	call_deferred("add_child", obj)
