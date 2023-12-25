extends GraphNode

@onready var main = get_tree().root.get_node("new_main")

var card_type = "jump"
var connection_count = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	set_slot(0,true,0,Color(Color.WHITE),true,0,Color(Color.GREEN))

func perform_operation():
	MM.emit_signal("set_curr_card","JUMP")
	GT.start()
	await GT.timeout
	MM.do_insert_line("Jump Card process is met. Jumping to specified card...", "normal")
	print("Jumping to next node")
	main.process_is_done()


