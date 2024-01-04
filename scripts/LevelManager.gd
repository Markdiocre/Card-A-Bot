extends Node

var level_example = "res://levels/example.json"
var level_1 = "res://levels/level_1.json"
var level_2 = "res://levels/level_2.json"
var level_3 = "res://levels/level_3.json"
var level_4 = "res://levels/level_4.json"
var level_5 = "res://levels/level_5.json"
var level_6 = "res://levels/level_6.json"
var level_7 = "res://levels/level_7.json"
var level_8 = "res://levels/level_8.json"
var level_9 = "res://levels/level_9.json"
var level_10 = "res://levels/level_10.json"
var level_11 = "res://levels/level_11.json"

var levels = [
	level_1,
	level_2,
	level_3,
	level_4,
	level_5,
	level_6,
	level_7,
	level_8,
	level_9,
	level_10,
	level_11
]

var level_descs = []

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
