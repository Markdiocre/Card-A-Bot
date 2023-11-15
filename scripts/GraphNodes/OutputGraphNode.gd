extends GraphNode

var card_type = "out"
var connection_count = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	set_slot(0,true,0,Color(Color.WHITE),true,0,Color(Color.GREEN))

func perform_operation():
	if MM.current_box_value == MM.OUTPUTS[MM.output_counter]:
		print("They are the same")
		MM.output_counter += 1
		MM.process_is_done()
	else:
		print("Ekis ka boi")
