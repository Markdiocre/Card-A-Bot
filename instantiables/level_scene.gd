class_name Level

extends Control
@onready var label = $Panel/Label
@onready var trophy = $Panel/trophy


var level_props

var is_completed = false
var level

func _ready():
	label.text = level_props["title"]
	

func make_complete():
	is_completed = true
	trophy.show()

func _on_panel_pressed():
	LM.current_level = level_props.duplicate(true)
	LM.make_level()
