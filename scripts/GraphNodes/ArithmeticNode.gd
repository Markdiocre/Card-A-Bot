extends GraphNode

var arithmetic_index = 0
var spin_value = 0

var card_type = "art"
var connection_count = 0

func _ready():
	set_slot(0,true,0,Color(Color.WHITE),true,0,Color(Color.GREEN))

func _on_option_button_item_selected(index):
	arithmetic_index = index

func _on_spin_box_value_changed(value):
	spin_value = value
