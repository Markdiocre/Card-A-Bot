extends GraphEdit

var inp = preload("res://instantiables/GraphNodes/InputGraphNode.tscn")
var out = preload("res://instantiables/GraphNodes/OutputGraphNode.tscn")
var inc = preload("res://instantiables/GraphNodes/IncGraphNode.tscn")
var dec = preload("res://instantiables/GraphNodes/DecGraphNode.tscn")

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
	temp.position_offset = Vector2(570, 428)
	add_child(temp)

func _on_inp_button_pressed():
	summon("inp")

func _on_connection_request(from_node, from_port, to_node, to_port):
	#should not connect by itself
	if from_node == to_node:
		return
	
	for node in get_connection_list():
		#Should only accept one input
		if node.to == to_node and node.to_port == to_port:
			return
			
		# Should update line if it is already connected to an input
		if node.from == from_node:
			disconnect_node(node.from, node.from_port,node.to,node.to_port)

				
	connect_node(from_node,from_port,to_node,to_port)
	


func _on_out__button_pressed():
	summon("out")


func _on_disconnection_request(from_node, from_port, to_node, to_port):
	disconnect_node(from_node,from_port,to_node,to_port)


func _on_inc__button_pressed():
	summon("inc")


func _on_dec_button_pressed():
	summon("dec")
