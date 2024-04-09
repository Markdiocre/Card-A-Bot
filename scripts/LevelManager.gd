extends Node

var level_descs = []

var current_level

enum LT {
	PREMADE,
	SANDBOX,
	IMPORT
}

var level_type

func _ready():
	level_descs = LevelStash.get_premade_levels()
		
func make_level(lev_type):
	level_type = LT[lev_type]
	get_tree().change_scene_to_file("res://Main/new_main.tscn")
	
func finish_level():
	
	SL.add_to_completed_levels(current_level["id"])
	get_tree().change_scene_to_file("res://Menu/LevelSelector.tscn")
	

	
func clear_levels():
	SL.completed_levels = []
	SL.save_game()
