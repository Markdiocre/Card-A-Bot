extends GraphNode

var card_type = "inp"
var connection_count = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	set_slot(0,true,0,Color(Color.WHITE),true,0,Color(Color.GREEN))

func perform_operation():
	MM.current_box_value = MM.INPUTS[MM.input_counter]
	MM.input_counter += 1
	MM.process_is_done()
