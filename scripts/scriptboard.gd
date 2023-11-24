extends Control

@onready var button_vert = $Buttons/Panel/BoxContainer/ButtonVert
@onready var counter_vert = $Buttons/Panel/BoxContainer/CounterVert
@onready var visualboard = $visualboard
@onready var level_desc = $Titles/Panel/level_desc

func _ready():
	MM.set_level_desc.connect(set_desc)

func _on_play_button_pressed():
	SceneTransition.do_transition()
	get_parent().go_to_playback()
	
func set_desc(desc,inputs,outputs):
	level_desc.text = desc
