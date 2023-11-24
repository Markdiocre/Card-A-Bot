extends VBoxContainer

@onready var inp_button = $"../ButtonVert/inp_button"


# Called when the node enters the scene tree for the first time.
func _ready():
	for panel in get_children():
		panel.custom_minimum_size = Vector2(inp_button.size.x/2, inp_button.size.y)

