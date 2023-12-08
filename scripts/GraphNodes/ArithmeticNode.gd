extends GraphNode

@onready var main = get_tree().root.get_node("new_main")
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
	MM.do_insert_line("Current value is now: " + str(main.current_box_value), "normal")
	
	

func perform_operation():
	MM.emit_signal("set_curr_card","ARITHMETIC")
	GT.start()
	await GT.timeout
	MM.do_insert_line("Performing arithmetic operation...", "normal")
	if main.current_box_value != null:
		if main.ARRAY_VALS[spin_value] != null:
			match arithmetic_index:
				0:
					GT.start()
					await GT.timeout
					
					MM.do_insert_line("Adding "+ str(main.current_box_value) + " to index "+ str(spin_value), "normal")
					main.current_box_value = main.current_box_value + main.ARRAY_VALS[spin_value]					
					GT.start()
					await GT.timeout
					current_value()
				1: 
					GT.start()
					await GT.timeout
					
					MM.do_insert_line("Subtracting "+ str(main.current_box_value) + " to index "+ str(spin_value), "normal")
					
					main.current_box_value = main.current_box_value - main.ARRAY_VALS[spin_value]
					GT.start()
					await GT.timeout
					current_value()
				2:
					GT.start()
					await GT.timeout
					
					MM.do_insert_line("Multiplying "+ str(main.current_box_value) + " to index "+ str(spin_value), "normal")
					
					main.current_box_value = main.current_box_value * main.ARRAY_VALS[spin_value]
					GT.start()
					await GT.timeout
					current_value()
				3:
					GT.start()
					await GT.timeout
					
					MM.do_insert_line("Dividing "+ str(main.current_box_value) + " to index "+ str(spin_value), "normal")
					
					main.current_box_value = int(floor(main.current_box_value / main.ARRAY_VALS[spin_value]))
					GT.start()
					await GT.timeout
					MM.do_insert_line("Current value is now: " + str(main.current_box_value), "normal")
				
				4:
					GT.start()
					await GT.timeout
					
					MM.do_insert_line("Applying Modulo of "+ str(main.current_box_value) + " to index "+ str(spin_value), "normal")
					
					main.current_box_value = int(floor(main.current_box_value % main.ARRAY_VALS[spin_value]))
					GT.start()
					await GT.timeout
					current_value()
					
			print("Value is now " + str(main.current_box_value))
			main.process_is_done()
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
