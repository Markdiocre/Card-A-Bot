extends GraphNode

@onready var main = get_tree().root.get_node("new_main")

var card_type = "copy"
var connection_count = 0

var index_value = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	set_slot(0,true,0,Color(Color.WHITE),true,0,Color(Color.GREEN))

func perform_operation():
	MM.emit_signal("set_curr_card", "COPY FROM")
	print("Copying value from index " + str(index_value))
	GT.start()
	await GT.timeout
	MM.do_insert_line("Copying value from index "+ str(index_value), "normal")
	if main.ARRAY_VALS[index_value] != null:
		main.current_box_value = main.ARRAY_VALS[index_value]
		print("Current value now is " + str(main.current_box_value))
		MM.do_insert_line("Current value now is " + str(main.current_box_value), "normal")
		main.process_is_done()
	else:
		GT.start()
		await GT.timeout
		MM.do_insert_line("ERROR: Array index is null", "error")
		GT.start()
		await GT.timeout
		MM.emit_signal("print_error","The index you're trying to copy from is empty")

func _on_spin_box_value_changed(value):
	index_value = int(value)
