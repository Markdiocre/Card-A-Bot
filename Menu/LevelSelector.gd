extends Control
var level_scene = preload("res://instantiables/level_scene.tscn")
@onready var grid = $levels/ScrollContainer/grid

var is_loaded = false

func _ready():
	SL.load_game()
	for i in range(0,LM.level_descs.size()):
		var lv = level_scene.instantiate()
		lv.custom_minimum_size = Vector2(168, 202)
		lv.level_props = LM.level_descs[i]
		lv.level = lv.level_props["level"]
		
		grid.add_child(lv)

		if lv.level in SL.completed_levels:
			lv.make_complete()
		
		
func _on_exit_pressed():
	get_tree().quit()
