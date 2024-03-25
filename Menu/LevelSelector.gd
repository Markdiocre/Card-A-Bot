extends Control
var level_scene = preload("res://instantiables/level_scene.tscn")
@onready var grid = $levels/ScrollContainer/grid

@onready var clear_ui = $clear_ui

var is_loaded = false

func instantiate_levels():
	for i in range(0,LM.level_descs.size()):
		var lv = level_scene.instantiate()
		lv.custom_minimum_size = Vector2(168, 202)
		lv.level_props = LM.level_descs[i]
		
		grid.add_child(lv)
		if lv.level_props.id in SL.completed_levels:
			lv.make_complete()

func _ready():
	SL.load_game()
	instantiate_levels()
	
	clear_ui.hide()
		
		
func _on_exit_pressed():
	get_tree().change_scene_to_file("res://Menu/MainMenu.tscn")


func _on_clear_pressed():
	
	clear_ui.show()



func _on_import_pressed():
	#TODO
	pass # Replace with function body.


func _on_create_pressed():
	#TODO
	pass # Replace with function body.


func _on_close_create_pressed():
	clear_ui.hide()


func _on_yes_create_pressed():
	LM.clear_levels()
	for child in grid.get_children():
		child.queue_free()

	instantiate_levels()
	clear_ui.hide()
