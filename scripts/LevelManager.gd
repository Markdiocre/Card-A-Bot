extends Node

var level_descs = []

var current_level

func _ready():
	level_descs = LevelStash.get_premade_levels()
		
func make_level():
	get_tree().change_scene_to_file("res://Main/new_main.tscn")
	
func finish_level():
	SL.add_to_completed_levels(current_level["id"])
	get_tree().change_scene_to_file("res://Menu/LevelSelector.tscn")
	
func json_to_utf8(json_var):
	var json_string = JSON.stringify(json_var)
	var base = Marshalls.utf8_to_base64(json_string)
	return base
	
func utf8_to_json(base_string):
	var converted = Marshalls.base64_to_utf8(base_string)
	var parsed = JSON.parse_string(converted)
	return parsed
	
func clear_levels():
	SL.completed_levels = []
	SL.save_game()
