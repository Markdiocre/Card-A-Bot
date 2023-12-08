extends GraphNode

@onready var main = get_tree().root.get_node("new_main")

var card_type = "out"
var connection_count = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	set_slot(0,true,0,Color(Color.WHITE),true,0,Color(Color.GREEN))

func perform_operation():
	MM.emit_signal("set_curr_card","OUTPUT")
	GT.start()
	await GT.timeout	
	MM.do_insert_line("Sending current value to output...", "normal")
	main.OUTPUTS_SUB.append(main.current_box_value)
	if main.current_box_value != null:
		GT.start()
		await GT.timeout	
		MM.do_insert_line("Checking output value...", "normal")
		if main.current_box_value == main.OUTPUTS[main.output_counter]:
			GT.start()
			await GT.timeout	
			MM.do_insert_line("Output value is correct! Proceeding...", "success")
			main.output_counter += 1
			main.process_is_done()
		else:
			GT.start()
			await GT.timeout	
			MM.do_insert_line("ERROR: Output value and expected value are not the same", "error")
			GT.start()
			await GT.timeout	
			MM.do_print_error("Wrong value")
	else:
		GT.start()
		await GT.timeout	
		MM.do_print_error("No current value")
