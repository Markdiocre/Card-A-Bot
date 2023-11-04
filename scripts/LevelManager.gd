extends Node

var _level = preload("res://levels/example.json")

var OUTPUTS
var INPUTS
var PROBLEM
var TITLE
var BUTTONS

func instantiate_level(file_path):
	var file = FileAccess.open(file_path, FileAccess.READ)
	var content_as_text = file.get_as_text()
	var dict = JSON.parse_string(content_as_text)
	OUTPUTS = dict["outputs"]
	INPUTS = dict["inputs"]
	PROBLEM = dict["problem"]
	TITLE = dict["title"]
	BUTTONS = dict["buttons"]

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
