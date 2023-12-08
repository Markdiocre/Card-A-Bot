extends Node

func _ready():
	get_parent().scale = Vector2(2, 2)
	if ["Android", "iOS"].has(OS.get_name()):
		get_parent().set_scale(Vector2(2, 2))
