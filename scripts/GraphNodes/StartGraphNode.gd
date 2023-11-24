extends GraphNode

var card_type = "start"
var connection_count = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	set_slot(0,false,0,Color(Color.WHITE),true,0,Color(Color.GREEN))

func perform_operation():
	GT.start()
	await GT.timeout	
	MM.emit_signal("insert_line","Start found. Executing flow...", "normal")
	MM.process_is_done()
