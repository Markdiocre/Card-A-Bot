extends Node

var completed_levels = []

signal game_loaded

func save():
	var save_dict = {
		"completed_levels" : completed_levels,
	}
	
	return save_dict

func save_game():
	var game_file = FileAccess.open("user://savegame.save", FileAccess.WRITE)
	var node_data = save()
	var json_string = JSON.stringify(node_data)
	
	game_file.store_line(json_string)
	
func delete_progress():
	var game_file = FileAccess.open("user://savegame.save", FileAccess.WRITE)
	
func add_to_completed_levels(level):
	if level not in completed_levels:
		completed_levels.append(level)
	save_game()
	
func load_game():
	if not FileAccess.file_exists("user://savegame.save"):
		return # Error! We don't have a save to load.
		
	var game_file = FileAccess.open("user://savegame.save", FileAccess.READ)
	while game_file.get_position() < game_file.get_length():
		var json_string = game_file.get_line()

		# Creates the helper class to interact with JSON
		var json = JSON.new()
		
		# Check if there is any error while parsing the JSON string, skip in case of failure
		var parse_result = json.parse(json_string)
		if not parse_result == OK:
			print("JSON Parse Error: ", json.get_error_message(), " in ", json_string, " at line ", json.get_error_line())
			continue
			
		# Get the data from the JSON object
		var node_data = json.get_data()
		
		completed_levels = node_data["completed_levels"]
	
	emit_signal("game_loaded")
