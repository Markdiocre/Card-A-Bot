extends Node

enum GAME_STATE{
	ARRANGING,
	PLAYING,
	ERROR
}

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
var next_node = null
var has_start = false

func set_state(state):
	current_game_state = state

func error_raise(_error,_node):
	#Make an error pop-up at the same time highlight the node that emitted the error
	pass

func _physics_process(_delta):
	match current_game_state:
		GAME_STATE.ARRANGING:
			pass
		GAME_STATE.PLAYING:
			#If there is no graph being crawled on, find the start node
			if current_graph == null:
				if visualboard.get_connection_list() == []:
					print("There are no connections made or simply there is no start node")
					set_state(GAME_STATE.ARRANGING)
					#TODO Go back to scriptboard
					return
				
				for link in visualboard.get_connection_list():
					#Check if the connection involves start
					if link.from == "StartGraphNode":
						current_graph = link
						next_node = link.to
						has_start = true
						
				if not has_start:
					#TODO: Raise error here
					print("No start node")
					set_state(GAME_STATE.ARRANGING)
					return
			else:
				#TODO
				#For every node.to, perform their operation (Along with their animation)
				#Find a way to make it one at a time 
				pass
				
			

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
	#TODO: Change scene to main
	
func run_simulation():
	current_graph = null
	current_node = null
	next_node = null
	set_state(GAME_STATE.PLAYING)
