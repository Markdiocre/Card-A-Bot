extends GraphNode

var card_type = "out"
var connection_count = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	set_slot(0,true,0,Color(Color.WHITE),true,0,Color(Color.GREEN))

func perform_operation():
	GT.start()
	await GT.timeout	
	MM.do_insert_line("Sending current value to output...", "normal")
	if MM.current_box_value != null:
		GT.start()
		await GT.timeout	
		MM.do_insert_line("Checking output value...", "normal")
		if MM.current_box_value == MM.OUTPUTS[MM.output_counter]:
			GT.start()
			await GT.timeout	
			MM.do_insert_line("Output value is correct! Proceeding...", "success")
			MM.output_counter += 1
			MM.process_is_done()
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
