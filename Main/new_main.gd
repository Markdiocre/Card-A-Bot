extends Control

@onready var playback = $playback
@onready var scriptboard = $scriptboard
@onready var main_cam = $MainCam
@onready var visualboard = scriptboard.get_node("visualboard")


enum GAME_STATE{
	ARRANGING,
	PLAYING,
	ERROR
}

#signal print_error(error:String)
#signal level_instantiated
#signal simulation_started
#signal error_message_closed
#signal closed_card(from)
#signal getting_connections
#signal set_level_desc(desc, inputs, outputs)
#signal set_curr_card(card_name)
#signal program_success
#
#signal insert_line(message, type)

var current_game_state = 0

var OUTPUTS
var INPUTS
var PROBLEM
var TITLE
var BUTTONS
var ARRAY_VALS = []
var INPUTS_ACQ = []
var OUTPUTS_SUB = []


var current_graph = null
var current_node = null
var next_node = null
var has_start = false

var input_counter = 0
var output_counter = 0
var is_doing_something = false
var is_carrying_a_box = false
var current_box_value
var is_the_end_card = false


func if_process(card_name ,port):
	for link in visualboard.get_connection_list():
		if link.from == card_name and link.from_port == port:
			current_graph = link
			process_is_done()
	
func set_state(state):
	current_game_state = state

func _physics_process(_delta):
	match current_game_state:
		GAME_STATE.ARRANGING:
			pass
		GAME_STATE.PLAYING:
			#If there is no graph being crawled on, find the start node
			
			if current_graph == null:
				
				
				if visualboard.get_connection_list() == []:
					MM.do_insert_line("ERROR: Start card is not connected to other cards...", "error")
					MM.do_print_error("Start Card is not connected to anything. Connect it first then re-run your algorithm")
					set_state(GAME_STATE.ARRANGING)
					return
				
				for link in visualboard.get_connection_list():
					#Check if the connection involves start
					if link.from == "StartGraphNode":
						current_graph = link
						next_node = link.to
						has_start = true
						
				if not has_start:
					#TODO: Raise error here
					MM.do_print_error("Start Card is not connected to anything. Connect it first then re-run your algorithm")
					set_state(GAME_STATE.ARRANGING)
					return
			else:
				if not is_doing_something and not is_the_end_card:
					perform_process()
					

#func do_print_error(message):
#	emit_signal("print_error", message)
#
#func do_insert_line(message, type):
#
#	emit_signal("insert_line", message, type)
	

func get_this_connection(card_name: String, port):
	print("Getting connection of " + card_name + " From port " + str(port))
	var card_exist = false
	for link in visualboard.get_connection_list():
		if link.from == card_name and link.from_port == port:
			current_graph = link
			card_exist = true
	
	if card_exist == false:
		print(card_name + " is the last card")
		is_the_end_card = true
		perform_process()
#		print("The card is the enasdasdasdsdd")

func process_is_done(port = 0):
	print("Process done")
	
	if is_the_end_card == false:
		if output_counter == OUTPUTS.size():
			GT.start()
			await GT.timeout
			MM.do_insert_line("PROGRAM IS A SUCCESS!", "success")
			MM.emit_signal("program_success")
		else:
			get_this_connection(current_graph.to, port)
			is_doing_something = false
		
	elif is_the_end_card == true:
		GT.start()
		await GT.timeout
		if output_counter != OUTPUTS.size():
			MM.do_print_error("You did not met the desired outputs. Back to the drawing board!")
		else:
			MM.do_insert_line("PROGRAM IS A SUCCESS!", "success")
			MM.emit_signal("program_success")
			
	

func perform_process():
	is_doing_something = true
	current_node = null
	if is_the_end_card == false:
		current_node = visualboard.get_node(""+current_graph.from)
#		current_node = visualboard.get_node(""+current_graph.to)
	else:
		current_node = visualboard.get_node(""+current_graph.to)
	print("Performing process of " + current_node.name)
	current_node.perform_operation()

func instantiate_level(dict):
#	var file = FileAccess.get_file_as_string(file_path)
#	var content_as_text = file.get_as_text()
#	var dict = JSON.parse_string(file)
	OUTPUTS = dict["outputs"]
	INPUTS = dict["inputs"]
	PROBLEM = dict["problem"]
	TITLE = dict["title"]
	BUTTONS = dict["buttons"]
	
	set_state(GAME_STATE.ARRANGING)
	SceneTransition.find_main()
	MM.emit_signal("level_instantiated")
	MM.emit_signal("set_level_desc", PROBLEM, INPUTS,OUTPUTS)
	#TODO: Change scene to main
	
func run_simulation():
	current_graph = null
	current_node = null
	next_node = null
	has_start = false
	is_the_end_card = false
	input_counter = 0
	output_counter = 0
	is_doing_something = false
	current_box_value = null
	ARRAY_VALS = []
	ARRAY_VALS.resize(6)
	ARRAY_VALS.fill(null)
	INPUTS_ACQ = []
	OUTPUTS_SUB = []
	set_state(GAME_STATE.PLAYING)
	
	
	MM.emit_signal("simulation_started")
	MM.do_insert_line("Locating start...","start")
	


var debug_mode = true

# Called when the node enters the scene tree for the first time.
func _ready():
	go_to_scriptboard()
	instantiate_level(LM.current_level)
	MM.error_message_closed.connect(handle_close_message)
	MM.get_connection_from_if.connect(if_process)	

func go_to_playback():
	main_cam.global_position = Vector2(playback.global_position.x  +  (get_viewport_rect().size.x / 2), playback.global_position.y +  (get_viewport_rect().size.y/ 2))
	
func go_to_scriptboard():
	main_cam.global_position = Vector2(scriptboard.global_position.x  + (get_viewport_rect().size.x / 2), scriptboard.global_position.y +  (get_viewport_rect().size.y/ 2))
	
func handle_close_message():
	go_to_scriptboard()
