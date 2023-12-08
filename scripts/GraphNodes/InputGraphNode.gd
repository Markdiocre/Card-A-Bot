extends GraphNode

@onready var main = get_tree().root.get_node("new_main")

var card_type = "inp"
var connection_count = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	set_slot(0,true,0,Color(Color.WHITE),true,0,Color(Color.GREEN))

func perform_operation():
	MM.emit_signal("set_curr_card", "INPUT")
	GT.start()
	await GT.timeout
	MM.do_insert_line("Getting input...", "normal")	
	if main.INPUTS[main.input_counter] != null:
		main.current_box_value = int(main.INPUTS[main.input_counter])
		main.input_counter += 1
		main.INPUTS_ACQ.append(main.current_box_value)
		GT.start()
		await GT.timeout	
		MM.do_insert_line("Current value is now " + str(main.current_box_value), "normal")
		main.process_is_done()
	else:
		GT.start()
		await GT.timeout	
		MM.do_print_error("There are no more inputs")
