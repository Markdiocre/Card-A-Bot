extends GraphNode

var card_type= "jumpif"
var connection_port_TRUE_bool = false
var connection_port_FALSE_bool = false


var condition = 0
var spin_value = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	set_slot(1,true,0,Color(Color.WHITE),true,1,Color(Color.GREEN))
	set_slot(2,false,0,Color(Color.WHITE),true,2,Color(Color.RED))


func _on_option_button_item_selected(index):
	condition = index


func _on_spin_box_value_changed(value):
	spin_value = value

