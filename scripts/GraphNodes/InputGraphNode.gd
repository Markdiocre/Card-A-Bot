extends GraphNode


# Called when the node enters the scene tree for the first time.
func _ready():
	set_slot(0,true,0,Color(Color.WHITE),true,0,Color(Color.GREEN))


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_close_request():
	#Remove previous connections before deleting
	for node in get_parent().get_connection_list():
		if node.to == name or node.from == name:
			get_parent().disconnect_node(node.from, node.from_port,node.to,node.to_port)
	queue_free()
