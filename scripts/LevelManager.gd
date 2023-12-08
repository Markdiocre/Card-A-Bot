extends Node

var level_example = "res://levels/example.json"
var level_1 = "res://levels/level_1.json"
var level_2 = "res://levels/level_2.json"
var level_3 = "res://levels/level_3.json"
var level_4 = "res://levels/level_4.json"
var level_5 = "res://levels/level_5.json"

var levels = [
	level_1,
	level_2,
	level_3,
	level_4,
	level_5
]

var level_descs = [
	
]

var current_level

func _ready():
	for i in levels:
		var file = FileAccess.get_file_as_string(i)
		var dict = JSON.parse_string(file)
		level_descs.append(dict)
		
func make_level():
	get_tree().change_scene_to_file("res://Main/new_main.tscn")
	
func go_to_next_level():
	SL.add_to_completed_levels(current_level["level"])
	SL.save_game()
	for i in level_descs:
		if current_level["level"] + 1 == int(i["level"]):
			current_level = i
			break


	get_tree().change_scene_to_file("res://Main/new_main.tscn")
