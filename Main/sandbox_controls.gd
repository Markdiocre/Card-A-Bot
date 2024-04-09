extends Control

#scriptboard
@onready var scriptboard = get_parent()

#sandbox controls
@onready var sandbox_controls = $sandbox_controls_ui
@onready var import_ui = $import_ui

#Descriptions
#@onready var title_edit = $sandbox_controls_ui/Panel/ScrollContainer/main/title_input/title_edit
@onready var desc_edit = $sandbox_controls_ui/Panel/ScrollContainer/main/desc_input/desc_edit

#Trackers
@onready var inp_edit = $sandbox_controls_ui/Panel/ScrollContainer/main/input_input/inp_edit
@onready var output_edit = $sandbox_controls_ui/Panel/ScrollContainer/main/output_input/output_edit

#Spinners
@onready var input_cards_spinner = $sandbox_controls_ui/Panel/ScrollContainer/main/GridContainer/input_cards/input_cards_spinner
@onready var output_cards_spinner = $sandbox_controls_ui/Panel/ScrollContainer/main/GridContainer/output_cards/output_cards_spinner
@onready var arithmetic_cards_spinner = $sandbox_controls_ui/Panel/ScrollContainer/main/GridContainer/arithmetic_cards/arithmetic_cards_spinner
@onready var jump_cards_spinner = $sandbox_controls_ui/Panel/ScrollContainer/main/GridContainer/jump_card/jump_cards_spinner
@onready var jumpif_card_spinner = $sandbox_controls_ui/Panel/ScrollContainer/main/GridContainer/jumpif_card/jumpif_card_spinner
@onready var store_card_spinner = $sandbox_controls_ui/Panel/ScrollContainer/main/GridContainer/store_card/store_card_spinner
@onready var copy_card_spinner = $sandbox_controls_ui/Panel/ScrollContainer/main/GridContainer/store_card2/copy_card_spinner

@onready var code = $import_ui/Panel/code
@onready var import_time = $import_ui/import_time

var regex = RegEx.new()
var inp_old_text = ""
var inp_old_caret_position = 0

var out_old_text = ""
var out_old_caret_position = 0

var is_import_valid = false

func _ready():
	regex.compile("[0-9 ]")
	
	desc_edit.text = SandBoxManager.sandbox_settings["problem"]
	inp_edit.text = array_to_string(SandBoxManager.sandbox_settings["inputs"])
	output_edit.text = array_to_string(SandBoxManager.sandbox_settings["outputs"])
	input_cards_spinner.value = SandBoxManager.sandbox_settings["buttons"]["inp"]["count"]
	output_cards_spinner.value = SandBoxManager.sandbox_settings["buttons"]["out"]["count"]
	arithmetic_cards_spinner.value = SandBoxManager.sandbox_settings["buttons"]["art"]["count"]
	jump_cards_spinner.value = SandBoxManager.sandbox_settings["buttons"]["jump"]["count"]
	jumpif_card_spinner.value = SandBoxManager.sandbox_settings["buttons"]["jumpif"]["count"]
	store_card_spinner.value = SandBoxManager.sandbox_settings["buttons"]["store"]["count"]
	copy_card_spinner.value = SandBoxManager.sandbox_settings["buttons"]["copy"]["count"]
	
	import_ui.hide()

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
		out_old_caret_position = output_edit.get_caret_column()
		var text = ""
		
		for valid_text in regex.search_all(new_text):
			text += valid_text.get_string()

		output_edit.text = text
		out_old_text = text
		output_edit.set_caret_column(out_old_caret_position)
	else:
		output_edit.text = out_old_text
		output_edit.set_caret_column(out_old_caret_position)
		

func _on_open_sandbox_pressed():
	sandbox_controls.show()


func _on_close_sandbox_pressed():
	sandbox_controls.hide()

func string_to_array(spaced_string: String):
	if spaced_string == "":
		return []
		
	var string_array = spaced_string.split(' ',false)
	var int_array = []
	
	for val in string_array:
		int_array.append(int(val))
	
	return int_array
	
func array_to_string(arr):
	var s = ""
	for x in arr:
		s+= String.num_int64(x) + " "
		
	return s
	
func _on_instantiate_sandbox_pressed():
	SandBoxManager.sandbox_settings["problem"] = desc_edit.text
	SandBoxManager.sandbox_settings["inputs"] = string_to_array(inp_edit.text)
	SandBoxManager.sandbox_settings["outputs"] = string_to_array(output_edit.text)
	SandBoxManager.sandbox_settings["buttons"]["inp"]["count"] = int(input_cards_spinner.get_line_edit().text)
	SandBoxManager.sandbox_settings["buttons"]["out"]["count"] = int(output_cards_spinner.get_line_edit().text)
	SandBoxManager.sandbox_settings["buttons"]["art"]["count"] = int(arithmetic_cards_spinner.get_line_edit().text)
	SandBoxManager.sandbox_settings["buttons"]["jump"]["count"] = int(jump_cards_spinner.get_line_edit().text)
	SandBoxManager.sandbox_settings["buttons"]["jumpif"]["count"] = int(jumpif_card_spinner.get_line_edit().text)
	SandBoxManager.sandbox_settings["buttons"]["store"]["count"] = int(store_card_spinner.get_line_edit().text)
	SandBoxManager.sandbox_settings["buttons"]["copy"]["count"] = int(copy_card_spinner.get_line_edit().text)
	
	SandBoxManager.grab_copy()
	LM.make_level("SANDBOX")


func _on_import_pressed():
	sandbox_controls.hide()
	import_ui.show()


func _on_close_import_pressed():
	sandbox_controls.show()
	import_ui.hide()


func _on_instantiate_import_pressed():
	var data = SandBoxManager.utf8_to_json(code.text)
	var panel = $import_ui/Panel
	if data != null:
		SandBoxManager.import_level(data)
	else:
		panel.modulate = Color.DARK_RED
		import_time.start()


func _on_import_time_timeout():
	var panel = $import_ui/Panel
	panel.modulate = Color.WHITE
