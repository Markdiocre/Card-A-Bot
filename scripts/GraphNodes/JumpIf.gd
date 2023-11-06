extends GraphNode

var card_type= "jumpif"

# Called when the node enters the scene tree for the first time.
func _ready():
	set_slot(2,true,0,Color(Color.WHITE),true,1,Color(Color.GREEN))
	set_slot(3,false,0,Color(Color.WHITE),true,2,Color(Color.RED))
