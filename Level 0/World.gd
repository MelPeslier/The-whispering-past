extends Node2D

@onready var moon_bar: PackedScene = preload("res://UI/moon_bar.tscn")
@onready var sun_bar: PackedScene = preload("res://UI/sun_bar.tscn")

var total: int = 0
var pos: int = 5
var neg: int = 7

func _ready() -> void:
	Events.connect("add_point", _on_add_point)

func _on_add_point(type: Events.Type):
	match type:
		Events.Type.MOON:
			if total <= 0:
				total -= pos
			else:
				total -= neg
			
		Events.Type.SUN:
			if total >= 0:
				total += pos
			else:
				total += neg
	
	if total < -100:
		total = -100
	elif total > 100:
		total = 100
	
	if total > 0:
		Events.emit_signal("add_sun", total)
		Events.emit_signal("add_moon", 0)
	elif total < 0:
		Events.emit_signal("add_moon", abs(total))
		Events.emit_signal("add_sun", 0)
	else:
		Events.emit_signal("add_moon", 0)
		Events.emit_signal("add_moon", 0)
