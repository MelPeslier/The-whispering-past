extends Node

enum Type {
	MOON,
	SUN,
}

signal spawn(type: Type, _pos: Vector2)

signal add_point(type: Type)

signal add_moon(value: int)

signal add_sun(value: int)
