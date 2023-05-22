extends Camera2D

@onready var ambiant: AudioStreamPlayer2D = $Ambiant
@onready var ui_canvas: CanvasLayer = $"../../../UICanvas"

@onready var sun_end: CanvasLayer = $"../../../SunEnd"
@onready var no_choose_end: CanvasLayer = $"../../../NoChooseEnd"
@onready var moon_end: CanvasLayer = $"../../../MoonEnd"

func _ready() -> void:
	ambiant.play()
	Events.connect("end_cinematic", _on_end_cinematic)

func _on_end_cinematic(val: int) -> void:
	var time: float = 1
	ui_canvas.visible = false
	match val:
		0:
			sun_end.visible = true
			sun_end.get_node("maudio").play()
			time = 11
		1:
			moon_end.visible = true
			moon_end.get_node("maudio").play()
			time = 8
		2:
			no_choose_end.visible = true
			no_choose_end.get_node("maudio").play()
			time = 6
	
	await get_tree().create_timer(time).timeout
	Events.emit_signal("free_them_all")
	get_tree().change_scene_to_file("res://Scenes/splash_screen.tscn")

