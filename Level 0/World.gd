extends Node2D

@onready var moon_bar: PackedScene = preload("res://UI/moon_bar.tscn")
@onready var sun_bar: PackedScene = preload("res://UI/sun_bar.tscn")

var total: int = 0
var pos: int = 5
var neg: int = 7

func _ready() -> void:
	Events.connect("add_point", _on_add_point)
	Events.connect("cut_scene", _on_cut_scene)

func _on_add_point(type: Events.Type) -> void:
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
		Events.emit_signal("add_to_bar", Events.Type.SUN, total)
		Events.emit_signal("add_to_bar", Events.Type.MOON, 0)
	elif total < 0:
		Events.emit_signal("add_to_bar", Events.Type.MOON, abs(total))
		Events.emit_signal("add_to_bar", Events.Type.SUN,0)
	else:
		Events.emit_signal("add_to_bar",Events.Type.SUN, 0)
		Events.emit_signal("add_to_bar",Events.Type.MOON, 0)


func _on_cut_scene():
	var u: int
	if total > 80:
		u = 0
		$AudioStreamPlayer.play()
	
	elif total < -80:
		u = 1
		$AudioStreamPlayer2.play()
	
	else:
		u = 2
		$AudioStreamPlayer3.play()
	
	await get_tree().create_timer(15).timeout 
	Events.emit_signal("end_cinematic", u)
