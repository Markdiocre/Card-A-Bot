extends Node2D

@onready var desc_box = $Control/DescBox
@onready var desc_label = $Control/DescBox/DescLabel
@onready var input_label = $Control/Inputs/InputLabel
@onready var output_label = $Control/Outputs/OutputLabel

# Called when the node enters the scene tree for the first time.
func _ready():
	#Load Level
	LoadLevel.instantiate_level("res://ExampleLevel.json")
	desc_label.text = LoadLevel.LEVEL_DESC
	input_label.text = str(LoadLevel.INPUTS.slice(0,5))
	output_label.text = str(LoadLevel.OUTPUTS.slice(0,5))
	#Control Level Desc UI
	desc_box.size.y = desc_label.size.y + 20
	
