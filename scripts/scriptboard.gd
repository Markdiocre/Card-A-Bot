extends Control

@onready var main = get_parent()

@onready var button_vert = $Buttons/Panel/BoxContainer/ButtonVert
@onready var counter_vert = $Buttons/Panel/BoxContainer/CounterVert
#@onready var visualboard = $visualboard
@onready var level_desc = $Titles/Panel/level_desc
@onready var inps_label = $Titles/inps/inps_label
@onready var outs_label = $Titles/outs/outs_label

@onready var titles = $Titles
@onready var buttons = $Buttons


func _ready():
	MM.set_level_desc.connect(set_desc)
	
func set_desc(desc,inputs,outputs):
	level_desc.text = desc
	inps_label.text = ",".join(inputs)
	outs_label.text = ",".join(outputs)

func _on_play_pressed():
	SceneTransition.do_transition()
	get_parent().go_to_playback()


func _on_exit_pressed():
	get_tree().change_scene_to_file("res://Menu/LevelSelector.tscn")

func _on_check_button_toggled(button_pressed):
	if button_pressed:
		buttons.hide()
		titles.hide()
	else:
		buttons.show()
		titles.show()
