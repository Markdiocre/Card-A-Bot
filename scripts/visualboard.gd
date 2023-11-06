extends GraphEdit

var inp = preload("res://instantiables/GraphNodes/InputGraphNode.tscn")
var out = preload("res://instantiables/GraphNodes/OutputGraphNode.tscn")
var inc = preload("res://instantiables/GraphNodes/IncGraphNode.tscn")
var dec = preload("res://instantiables/GraphNodes/DecGraphNode.tscn")
var add = preload("res://instantiables/GraphNodes/AddGraphNode.tscn")
var sub = preload("res://instantiables/GraphNodes/SubGraphNode.tscn")
var jump = preload("res://instantiables/GraphNodes/JumpGraphNode.tscn")
var jumpif = preload("res://instantiables/GraphNodes/JumpIfGraphNode.tscn")

func _ready():
	add_valid_connection_type(1,0)
	add_valid_connection_type(2,0)
	

func summon(type: String):
	var temp
	match type:
		"inp":
			temp = inp.instantiate()
		"out":
			temp = out.instantiate()
		"inc":
			temp = inc.instantiate()
		"dec":
			temp = dec.instantiate()
		"add":
			temp = add.instantiate()
		"sub":
			temp = sub.instantiate()
		"jump":
			temp = jump.instantiate()
		"jumpif":
			temp = jumpif.instantiate()
	temp.position_offset = Vector2(570, 428)
	add_child(temp)

func _on_inp_button_pressed():
	summon("inp")

func _on_connection_request(from_node, from_port, to_node, to_port):
	#should not connect by itself
	var allowed = false
	var from_node_instance = get_node(""+from_node)
	var to_node_instance = get_node(""+to_node)
	
	
	if from_node == to_node:
		return
	
	
	match from_node_instance.card_type:
		"jump":
			var connection_count = 0
			#Connect regardless if there is an initial connection
			for node in get_connection_list():
			# Should update line if it is already connected to an input
				if node.from == from_node:
					connection_count += 1
			
			if connection_count > 0:
				return
			
			#Should not connect to other jumps
			if to_node_instance.card_type == "jump" or to_node_instance.card_type == "jumpif":
				return
				
			allowed = true
			
		"jumpif":
			var connection_port_TRUE_count = 0
			var connection_port_FALSE_count = 0

			for node in get_connection_list():
				#A TRUE port is already connected to something
				if node.from_port==0 and node.from == from_node:
					connection_port_TRUE_count += 1
				#A FALSE port is already connected to something
				elif  node.from_port==1 and node.from == from_node:
					connection_port_FALSE_count += 1
					
			
			#Should not connect to other jumps
			if to_node_instance.card_type == "jump" or to_node_instance.card_type == "jumpif":
				return
			
			if connection_port_TRUE_count == 0 or connection_port_FALSE_count == 0:
				allowed = true
				
			
		"start":
			var connection_count = 0
			for node in get_connection_list():
				#Should only accept one input
				if node.to == to_node and node.to_port == to_port:
					return
					
				if node.from == from_node:
					connection_count +=1
					
			if connection_count == 0:
				allowed = true
				
			#Should not connect to other jumps
			if to_node_instance.card_type == "jump" or to_node_instance.card_type == "jumpif":
				return
				
		_: #default
			var connection_count = 0
			for node in get_connection_list():
				#Should only accept one input
				if node.to == to_node and node.to_port == to_port:
					return
					
				if node.from == from_node:
					connection_count +=1
					
			if connection_count == 0:
				allowed = true
		

	if allowed:
		connect_node(from_node,from_port,to_node,to_port)
		
	


func _on_out__button_pressed():
	summon("out")


func _on_disconnection_request(from_node, from_port, to_node, to_port):
	disconnect_node(from_node,from_port,to_node,to_port)


func _on_inc__button_pressed():
	summon("inc")


func _on_dec_button_pressed():
	summon("dec")


func _on_add_button_pressed():
	summon("add")

func _on_sub_button_pressed():
	summon("sub")



func _on_jump_button_pressed():
	summon("jump")


func _on_jumpif_button_pressed():
	summon("jumpif")
