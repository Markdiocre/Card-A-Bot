extends GraphNode

# Arithmetic Index
# 0 - ADD
# 1 - SUBTRACT
# 2 - MULTIPLY
# 3 - DIVIDE
# 4 - MODULO

var arithmetic_index = 0

var spin_value = 0

var card_type = "art"
var connection_count = 0

func _ready():
	set_slot(0,true,0,Color(Color.WHITE),true,0,Color(Color.GREEN))

func _on_option_button_item_selected(index):
	arithmetic_index = index

func _on_spin_box_value_changed(value):
	spin_value = int(value)

func current_value():
	MM.do_insert_line("Current value is now: " + str(MM.current_box_value), "normal")
	
	

func perform_operation():
	GT.start()
	await GT.timeout
	MM.do_insert_line("Performing arithmetic operation...", "normal")
	if MM.current_box_value != null:
		if MM.ARRAY_VALS[spin_value] != null:
			match arithmetic_index:
				0:
					GT.start()
					await GT.timeout
					
					MM.do_insert_line("Adding "+ str(MM.current_box_value) + " to index "+ str(spin_value), "normal")
					MM.current_box_value = MM.current_box_value + MM.ARRAY_VALS[spin_value]					
					GT.start()
					await GT.timeout
					current_value()
				1: 
					GT.start()
					await GT.timeout
					
					MM.do_insert_line("Subtracting "+ str(MM.current_box_value) + " to index "+ str(spin_value), "normal")
					
					MM.current_box_value = MM.current_box_value - MM.ARRAY_VALS[spin_value]
					GT.start()
					await GT.timeout
					current_value()
				2:
					GT.start()
					await GT.timeout
					
					MM.do_insert_line("Multiplying "+ str(MM.current_box_value) + " to index "+ str(spin_value), "normal")
					
					MM.current_box_value = MM.current_box_value * MM.ARRAY_VALS[spin_value]
					GT.start()
					await GT.timeout
					current_value()
				3:
					GT.start()
					await GT.timeout
					
					MM.do_insert_line("Dividing "+ str(MM.current_box_value) + " to index "+ str(spin_value), "normal")
					
					MM.current_box_value = int(floor(MM.current_box_value / MM.ARRAY_VALS[spin_value]))
					GT.start()
					await GT.timeout
					MM.do_insert_line("Current value is now: " + str(MM.current_box_value), "normal")
				
				4:
					GT.start()
					await GT.timeout
					
					MM.do_insert_line("Applying Modulo of "+ str(MM.current_box_value) + " to index "+ str(spin_value), "normal")
					
					MM.current_box_value = int(floor(MM.current_box_value % MM.ARRAY_VALS[spin_value]))
					GT.start()
					await GT.timeout
					current_value()
					
			print("Value is now " + str(MM.current_box_value))
			MM.process_is_done()
		else:
			GT.start()
			await GT.timeout
			MM.do_insert_line("ERROR: The array you're trying to operate is empty", "error")
			MM.emit_signal("print_error","The array index is empty")
	else:
		GT.start()
		await GT.timeout
		MM.do_insert_line("ERROR: Current value is empty", "error")
		MM.emit_signal("print_error","There is no current box to be manipulated")
