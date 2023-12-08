extends Control

@onready var main = get_parent()

@onready var button_vert = $Buttons/Panel/BoxContainer/ButtonVert
@onready var counter_vert = $Buttons/Panel/BoxContainer/CounterVert
#@onready var visualboard = $visualboard
@onready var level_desc = $Titles/Panel/level_desc
@onready var inps_label = $Titles/inps/inps_label
@onready var outs_label = $Titles/outs/outs_label


func _ready():
	MM.set_level_desc.connect(set_desc)
	
func set_desc(desc,inputs,outputs):
	level_desc.text = desc
	inps_label.text = str(inputs)
	outs_label.text = str(outputs)

func _on_play_pressed():
	SceneTransition.do_transition()
	get_parent().go_to_playback()


func _on_exit_pressed():
	get_tree().change_scene_to_file("res://Menu/LevelSelector.tscn")
