extends Node

func _ready():
	if str(OS.get_name()) in ["Android", "iOS"]:
		get_parent().set_scale(Vector2(2, 2))
