extends Control


# Called when the node enters the scene tree for the first time.
@onready var inp_edit = $sandbox_controls/Panel/ScrollContainer/main/input_input/inp_edit
@onready var output_edit = $sandbox_controls/Panel/ScrollContainer/main/output_input/output_edit

var regex = RegEx.new()
var inp_old_text = ""
var inp_old_caret_position = 0

var out_old_text = ""
var out_old_caret_position = 0

func _ready():
	regex.compile("[0-9 ]")

func _on_inp_edit_text_changed(new_text):
	var space_count = new_text.count(" ")
	
	if space_count <= 4:
		inp_old_caret_position = inp_edit.get_caret_column()
		var text = ""
		
		for valid_text in regex.search_all(new_text):
			text += valid_text.get_string()

		inp_edit.text = text
		inp_old_text = text
		inp_edit.set_caret_column(inp_old_caret_position)
	else:
		inp_edit.text = inp_old_text
		inp_edit.set_caret_column(inp_old_caret_position)

func _on_output_edit_text_changed(new_text):
	var space_count = new_text.count(" ")
	
	if space_count <= 4:
		out_old_caret_position = inp_edit.get_caret_column()
		var text = ""
		
		for valid_text in regex.search_all(new_text):
			text += valid_text.get_string()

		output_edit.text = text
		out_old_text = text
		inp_edit.set_caret_column(out_old_caret_position)
	else:
		output_edit.text = out_old_text
		output_edit.set_caret_column(out_old_caret_position)
