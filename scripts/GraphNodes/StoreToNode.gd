extends GraphNode

@onready var main = get_tree().root.get_node("new_main")

var index_val = 0

var card_type = "store"
var connection_count = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	set_slot(0,true,0,Color(Color.WHITE),true,0,Color(Color.GREEN))


func perform_operation():
	MM.emit_signal("set_curr_card","STORE TO")
	GT.start()
	await GT.timeout
	MM.do_insert_line("Assigning current value to " + str(index_val), "normal")
	
	if  main.current_box_value != null:
		main.ARRAY_VALS[index_val] = main.current_box_value
		
		GT.start()
		await GT.timeout
		MM.do_insert_line("Value assigned. Array is now "+str(main.ARRAY_VALS), "normal")
		print(main.ARRAY_VALS)
		
		main.process_is_done()
	else:
		GT.start()
		await GT.timeout
		MM.do_insert_line("ERROR: There are no current value", "error")
		GT.start()
		await GT.timeout
		MM.emit_signal("print_error","There are no current value")

func _on_spin_box_value_changed(value):
	index_val = int(value)
