extends Node

var OUTPUTS
var INPUTS
var NUM_OF_CARTRIDGE
var LEVEL_DESC

func instantiate_level(file_path):
	var file = FileAccess.open(file_path, FileAccess.READ)
	var content_as_text = file.get_as_text()
	var dict = JSON.parse_string(content_as_text)
	OUTPUTS = dict["outputs"]
	INPUTS = dict["inputs"]
	NUM_OF_CARTRIDGE = dict["num_of_cartridge"]
	LEVEL_DESC = dict["level_description"]
