extends Node

enum GAME_STATE{
	ARRANGING,
	PLAYING,
	ERROR
}

signal print_error(error:String)
signal level_instantiated()
signal simulation_started()
signal error_message_closed()
signal closed_card(from)


var current_game_state = 0

var OUTPUTS
var INPUTS
var PROBLEM
var TITLE
var BUTTONS

@onready var scriptboard = get_tree().root.get_node("main").get_node("scriptboard")
@onready var visualboard = scriptboard.get_node("visualboard")

var current_graph = null
var current_node = null
#var next_node = null
var has_start = false

var input_counter = 0
var output_counter = 0
var is_doing_something = false
var is_carrying_a_box = false
var current_box_value

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
					
					emit_signal("print_error", "Start Card is not connected to anything. Connect it first then re-run your algorithm")
					set_state(GAME_STATE.ARRANGING)
					return
				
				get_this_connection("StartGraphNode")
#				for link in visualboard.get_connection_list():
#					#Check if the connection involves start
#					if link.from == "StartGraphNode":
#						current_graph = link
#						next_node = link.to
#						has_start = true
						
				if not has_start:
					#TODO: Raise error here
					emit_signal("print_error", "Start Card is not connected to anything. Connect it first then re-run your algorithm")
					set_state(GAME_STATE.ARRANGING)
					return
			else:
				if not is_doing_something:
					do_process(current_graph)

func get_this_connection(card_name: String):
	for link in visualboard.get_connection_list():
		if link.from == "StartGraphNode":
			has_start = true
			get_this_connection(link.to)
			break
			
		if link.from == card_name:
			current_graph = link
		else:
			break

func do_process(graph):
	is_doing_something = true
	current_node = visualboard.get_node(""+graph.from)
	print(current_node)
	match current_node.card_type:
		"inp":
			if not is_carrying_a_box:
				#TODO Handle inp
				print("Albert")
			else:
				emit_signal("print_error", "The robot do not have a box to manipulate. Check your algorithm then start again!")

func instantiate_level(file_path):
	var file = FileAccess.open(file_path, FileAccess.READ)
	var content_as_text = file.get_as_text()
	var dict = JSON.parse_string(content_as_text)
	OUTPUTS = dict["outputs"]
	INPUTS = dict["inputs"]
	PROBLEM = dict["problem"]
	TITLE = dict["title"]
	BUTTONS = dict["buttons"]
	
	set_state(GAME_STATE.ARRANGING)
	emit_signal("level_instantiated")
	#TODO: Change scene to main
	
func run_simulation():
	current_graph = null
	current_node = null
#	next_node = null
	has_start = false
	set_state(GAME_STATE.PLAYING)
	emit_signal("simulation_started")
