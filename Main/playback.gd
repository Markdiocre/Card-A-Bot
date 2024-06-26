extends Control

@onready var main = get_parent()

@onready var error_ui = $errorUI
@onready var win_ui = $winUI
@onready var win_message = $winUI/Panel/win_message


@onready var error_message = $errorUI/Panel/error_message
@onready var close_button = $errorUI/Panel/close_button
@onready var v_box_container = $cmd/Panel/ScrollContainer/VBoxContainer
@onready var color_rect = $errorUI/ColorRect
@onready var scroll_container = $cmd/Panel/ScrollContainer
@onready var scrollbar = $cmd/Panel/ScrollContainer.get_v_scroll_bar()

@onready var arr_0 = $trackers/Panel/Control/VBoxContainer/HBoxContainer/arr0/arr0
@onready var arr_1 = $trackers/Panel/Control/VBoxContainer/HBoxContainer/arr1/arr1
@onready var arr_2 = $trackers/Panel/Control/VBoxContainer/HBoxContainer/arr2/arr2
@onready var arr_3 = $trackers/Panel/Control/VBoxContainer/HBoxContainer2/arr3/arr3
@onready var arr_4 = $trackers/Panel/Control/VBoxContainer/HBoxContainer2/arr4/arr4
@onready var arr_5 = $trackers/Panel/Control/VBoxContainer/HBoxContainer2/arr5/arr5
@onready var curr_card = $trackers/Panel/current_card/curr_card
@onready var curr_value = $trackers/Panel/curr_value/curr_value
@onready var inps = $trackers/Panel/inps/inps
@onready var outs = $trackers/Panel/outs/outs
@onready var sandbox_ui_win = $sandbox_ui_win

#sounds
@onready var line_insert = $sounds/line_insert
@onready var win = $sounds/win
@onready var wrong = $sounds/wrong
@onready var copy_timer = $sandbox_ui_win/copy_timer
@onready var sandbox_panel = $sandbox_ui_win/sandbox_panel


var line = preload("res://instantiables/line.tscn")


var play_speed = 1

var button_messages = [
	"Aww man!",
	"Got it!",
	"OKKK",
	"Worth the try"
]

var win_messages = [
	"Who's the man? You're the man!",
	"Wow! You completed it!",
	"Level Complete!",
	"BROOO. That's bussin!",
	"Are you an expert? I feel like you are."
]

func _ready():
	error_ui.hide()
	win_ui.hide()
	sandbox_ui_win.hide()
	
	MM.print_error.connect(display_error_message)
	MM.insert_line.connect(insert_line)
	MM.simulation_started.connect(start_simulation)
	MM.program_success.connect(program_success)
	MM.set_curr_card.connect(set_curr)
	
func set_curr(card_name):
	curr_card.text = card_name

func program_success():
	win_ui.show()
	win_message.text = win_messages[randi_range(0, win_messages.size()-1)]
	curr_card.text = "COMPLETED"
	curr_value.text = "COMPLETED"
	win.play()
	

func update_arrays():
	arr_0.text = str(main.ARRAY_VALS[0])
	arr_1.text = str(main.ARRAY_VALS[1])
	arr_2.text = str(main.ARRAY_VALS[2])
	arr_3.text = str(main.ARRAY_VALS[3])
	arr_4.text = str(main.ARRAY_VALS[4])
	arr_5.text = str(main.ARRAY_VALS[5])
	
func start_simulation():
	for i in v_box_container.get_children():
		i.queue_free()
		
	update_arrays()
	curr_card.text = ""
	GT.wait_time = 1

	
	
func insert_line(message, type):
	var new_line = line.instantiate()
	new_line.text = message
	
	match type:
		"error":
			new_line.set("custom_colors/font_color", Color.RED)
		"start":
			new_line.set("custom_colors/font_color", Color.DARK_BLUE)
		"normal":
			new_line.set("custom_colors/font_color", Color.WHITE)
		"note":
			new_line.set("custom_colors/font_color", Color.YELLOW)
	
	v_box_container.add_child(new_line)
	line_insert.play()
	update_arrays()
	curr_value.text = str(main.current_box_value)
	inps.text = ",".join(main.INPUTS_ACQ)
	outs.text = ",".join(main.OUTPUTS_SUB)
	await get_tree().process_frame
	scroll_container.scroll_vertical = scrollbar.max_value

func display_error_message(message: String):
	close_button.text = button_messages[randi_range(0, button_messages.size()-1)]
	error_ui.show()
	error_message.text = message
	wrong.play()

func _on_close_button_pressed():
	error_ui.hide()
	MM.emit_signal("error_message_closed")
	
func _on_retry_button_pressed():

	#FOR PREMADE ONLY
	if LM.level_type == 0:
		for level in LM.level_descs:
			if int(LM.current_level["id"]) == int(level["id"]):
				LM.current_level = level.duplicate(true)
				
				
		LM.make_level("PREMADE")
	elif LM.level_type == 1:
		LM.make_level("SANDBOX")
	elif LM.level_type == 2:
		
		SandBoxManager.import_level(SandBoxManager.sandbox_settings)

func _on_next_button_pressed():
	if LM.level_type == 0:
		LM.finish_level()
	elif LM.level_type == 1:
		sandbox_ui_win.show()
	elif LM.level_type == 2:
		get_tree().change_scene_to_file("res://Menu/LevelSelector.tscn")


func _on_button_pressed():
	GT.wait_time = 0.01


func _on_close_sandbox_pressed():
	SandBoxManager.reset_settings()
	get_tree().change_scene_to_file("res://Menu/LevelSelector.tscn")
	LM.level_type = 0


func _on_edit_sandbox_pressed():
	win_ui.hide()
	sandbox_ui_win.hide()
	MM.emit_signal("error_message_closed")


func _on_copy_to_clipboard_pressed():
	
	sandbox_panel.modulate = Color.GREEN
	copy_timer.start()
	DisplayServer.clipboard_set(SandBoxManager.json_to_utf8(SandBoxManager.sandbox_settings))


func _on_copy_timer_timeout():
	sandbox_panel.modulate = Color.WHITE
