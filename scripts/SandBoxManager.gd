extends Node

var initial_settings = {
#		"id": "1",
		"title": "",
		"problem": "",
		"inputs":[],
		"outputs":[],
		"buttons":{
			"inp":{
				"count": 0
			},
			"out":{
				"count": 0
			},
			"art":{
				"count": 0
			},
			"jump":{
				"count": 0
			},
			"jumpif":{
				"count": 0
			},
			"store":{
				"count": 0
			},
			"copy":{
				"count": 0
			}
		}
	}
	
var sandbox_settings = {
#		"id": "1",
		"title": "",
		"problem": "",
		"inputs":[],
		"outputs":[],
		"buttons":{
			"inp":{
				"count": 0
			},
			"out":{
				"count": 0
			},
			"art":{
				"count": 0
			},
			"jump":{
				"count": 0
			},
			"jumpif":{
				"count": 0
			},
			"store":{
				"count": 0
			},
			"copy":{
				"count": 0
			}
		}
	}

#this is the one to be manipulated
var duplicate_settings

# Called when the node enters the scene tree for the first time.
func _ready():
	grab_copy()

func grab_copy():
	duplicate_settings = sandbox_settings.duplicate(true)
	
func reset_settings():
	sandbox_settings["title"] = ""
	sandbox_settings["problem"] = ""
	sandbox_settings["inputs"] = []
	sandbox_settings["outputs"] = []
	sandbox_settings["buttons"]["inp"]["count"] = 0
	sandbox_settings["buttons"]["out"]["count"] = 0
	sandbox_settings["buttons"]["art"]["count"] = 0
	sandbox_settings["buttons"]["jump"]["count"] = 0
	sandbox_settings["buttons"]["jumpif"]["count"] = 0
	sandbox_settings["buttons"]["store"]["count"] = 0
	sandbox_settings["buttons"]["copy"]["count"] = 0

func import_level(dict):
	sandbox_settings["title"] = dict["title"]
	sandbox_settings["problem"] = dict["problem"]
	sandbox_settings["inputs"] = dict["inputs"]
	sandbox_settings["outputs"] = dict["outputs"]
	sandbox_settings["buttons"]["inp"]["count"] = dict["buttons"]["inp"]["count"]
	sandbox_settings["buttons"]["out"]["count"] = dict["buttons"]["out"]["count"]
	sandbox_settings["buttons"]["art"]["count"] = dict["buttons"]["art"]["count"]
	sandbox_settings["buttons"]["jump"]["count"] = dict["buttons"]["jump"]["count"]
	sandbox_settings["buttons"]["jumpif"]["count"] = dict["buttons"]["jumpif"]["count"]
	sandbox_settings["buttons"]["store"]["count"] = dict["buttons"]["store"]["count"]
	sandbox_settings["buttons"]["copy"]["count"] = dict["buttons"]["copy"]["count"]
	grab_copy()
	
	if LM.level_type == 1:
		LM.make_level("SANDBOX")
	else:
		LM.make_level("IMPORT")

func json_to_utf8(json_var):
	var json_string = JSON.stringify(json_var)
	var base = Marshalls.utf8_to_base64(json_string)
	return base
	
func utf8_to_json(base_string):
	var converted = Marshalls.base64_to_utf8(base_string)
	var parsed = JSON.parse_string(converted)
	return parsed
