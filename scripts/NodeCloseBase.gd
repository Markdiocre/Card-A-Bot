extends Node

@onready var parent = get_parent()
@onready var visual_board = parent.get_parent()

func _ready():
	parent.close_request.connect(on_close_request)
	
func on_close_request():
	for node in visual_board.get_connection_list():
		if node.to == parent.name or node.from == parent.name:
			visual_board.disconnect_node(node.from, node.from_port,node.to,node.to_port)
	
	MM.emit_signal("closed_card",get_parent())
	
	parent.queue_free()
