class_name Level

extends Control
@onready var label = $Panel/Label
@onready var trophy = $Panel/trophy
@onready var diff = $Panel/diff


var level_props

var is_completed = false
var level

func get_difficulty():
	match level_props["difficulty"]:
		1: 
			return ["Easy", Color.DARK_GREEN]
		2: 
			return ["Medium", Color.DARK_GOLDENROD]
		3: 
			return ["Hard", Color.BROWN]

func _ready():
	label.text = level_props["title"]
	diff.text = get_difficulty()[0]
	diff.label_settings.font_color = get_difficulty()[1]

func make_complete():
	is_completed = true
	trophy.show()

func _on_panel_pressed():
	LM.current_level = level_props.duplicate(true)
	LM.make_level("PREMADE")
