extends GraphEdit

var inp = preload("res://instantiables/GraphNodes/InputGraphNode.tscn")
var out = preload("res://instantiables/GraphNodes/OutputGraphNode.tscn")
var art = preload("res://instantiables/GraphNodes/ArithmeticNode.tscn")
var jump = preload("res://instantiables/GraphNodes/JumpGraphNode.tscn")
var jumpif = preload("res://instantiables/GraphNodes/JumpIfGraphNode.tscn")

@export var offset_counter = 1
@export var offset_add = 20

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
		"art":
			temp = art.instantiate()
		"jump":
			temp = jump.instantiate()
		"jumpif":
			temp = jumpif.instantiate()
	temp.position_offset = Vector2(570 , 428 )
	
	for node in get_children():
		node.selected = false
		
	temp.selected = true
	
	
	add_child(temp)

func _on_inp_button_pressed():
	summon("inp")

func _on_connection_request(from_node, from_port, to_node, to_port):
	var allowed = false
	var from_node_instance = get_node(""+from_node)
	var to_node_instance = get_node(""+to_node)
	
	#should not connect by itself	
	if from_node == to_node:
		return
	
	
	match from_node_instance.card_type:
		"jump":
			#Connect regardless if there is an initial connection
			for node in get_connection_list():
			# Should update line if it is already connected to an input
				if node.from == from_node:
					from_node_instance.connection_count += 1
			
			if from_node_instance.connection_count > 0:
				return
			
			#Should not connect to other jumps
			if to_node_instance.card_type == "jump" or to_node_instance.card_type == "jumpif":
				return
				
			allowed = true
			
		"jumpif":

			for node in get_connection_list():
				#A TRUE port is already connected to something
				if node.from_port==0 and node.from == from_node:
					from_node_instance.connection_port_TRUE_bool = true
				#A FALSE port is already connected to something
				elif  node.from_port==1 and node.from == from_node:
					from_node_instance.connection_port_FALSE_bool = true
					
			
			#Should not connect to other jumps
			if to_node_instance.card_type == "jump" or to_node_instance.card_type == "jumpif":
				return
			
			if not from_node_instance.connection_port_TRUE_bool:
				allowed = true
			elif not from_node_instance.connection_port_FALSE_bool:
				allowed = true
				
			
		"start":
			for node in get_connection_list():
				#Should only accept one input
				if node.to == to_node and node.to_port == to_port:
					return
					
				if node.from == from_node:
					from_node_instance.connection_count +=1
					
			if from_node_instance.connection_count == 0:
				allowed = true
				
			#Should not connect to other jumps
			if to_node_instance.card_type == "jump" or to_node_instance.card_type == "jumpif":
				return
				
		_: #default
			for node in get_connection_list():
				#Should only accept one input
				if node.to == to_node and node.to_port == to_port:
					return
					
				if node.from == from_node:
					from_node_instance.connection_count +=1
					
			if from_node_instance.connection_count == 0:
				allowed = true
		

	if allowed:
		connect_node(from_node,from_port,to_node,to_port)
		
	


func _on_out__button_pressed():
	summon("out")


func _on_disconnection_request(from_node, from_port, to_node, to_port):
	var from_node_instance = get_node(""+from_node)
	
	if from_node_instance.card_type == "jumpif" and from_port == 0:
		from_node_instance.connection_port_TRUE_bool = false
	elif from_node_instance.card_type == "jumpif" and from_port == 1:
		from_node_instance.connection_port_FALSE_bool = false
	else:
		from_node_instance.connection_count = 0
		
	disconnect_node(from_node,from_port,to_node,to_port)


func _on_jump_button_pressed():
	summon("jump")


func _on_jumpif_button_pressed():
	summon("jumpif")


func _on_art__button_pressed():
	summon("art")
