extends GraphNode

var index_val = 0

var card_type = "store"
var connection_count = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	set_slot(0,true,0,Color(Color.WHITE),true,0,Color(Color.GREEN))


func perform_operation():
	GT.start()
	await GT.timeout
	MM.do_insert_line("Assigning current value to " + str(index_val), "normal")
	
	if  MM.current_box_value != null:
		MM.ARRAY_VALS[index_val] = MM.current_box_value
		
		GT.start()
		await GT.timeout
		MM.do_insert_line("Value assigned. Array is now "+str(MM.ARRAY_VALS), "normal")
		print(MM.ARRAY_VALS)
		
		MM.process_is_done()
	else:
		GT.start()
		await GT.timeout
		MM.do_insert_line("ERROR: There are no current value", "error")
		GT.start()
		await GT.timeout
		MM.emit_signal("print_error","There are no current value")

func _on_spin_box_value_changed(value):
	index_val = int(value)
