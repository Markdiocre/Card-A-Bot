extends Control

@onready var main = get_parent()

@onready var button_vert = $Buttons/Panel/BoxContainer/ButtonVert
@onready var counter_vert = $Buttons/Panel/BoxContainer/CounterVert
#@onready var visualboard = $visualboard
@onready var level_desc = $Titles/Panel/sc/level_desc
@onready var inps_label = $Titles/inps/inps_label
@onready var outs_label = $Titles/outs/outs_label

@onready var titles = $Titles
@onready var buttons = $Buttons
@onready var play_button = $PlayButton

@onready var play = $PlayButton/play
var sandbox = preload("res://instantiables/sandbox_controls.tscn")

func _ready():
	MM.set_level_desc.connect(set_desc)
	print(LM.level_type)
	if LM.level_type == 1:
		
		add_child(sandbox.instantiate())
		
		if SandBoxManager.sandbox_settings["inputs"] == [] or SandBoxManager.sandbox_settings["outputs"] == [] or SandBoxManager.sandbox_settings["problem"].is_empty():
			play.disabled = true
		
func set_desc(desc,inputs,outputs):
	if desc.is_empty():
		level_desc.text = "Empty. Simulation Disabled"
	else:
		level_desc.text = desc
	
	if inputs == []:
		inps_label.text = "Empty. Simulation Disabled"
	else:
		inps_label.text = ",".join(inputs)
		
	if outputs == []:
		outs_label.text = "Empty. Simulation Disabled"
	else:
		outs_label.text = ",".join(outputs)

func _on_play_pressed():
	SceneTransition.do_transition()
	get_parent().go_to_playback()


func _on_exit_pressed():
	if LM.level_type == 1:
		SandBoxManager.reset_settings()
	
	get_tree().change_scene_to_file("res://Menu/LevelSelector.tscn")
	LM.level_type = 0

func _on_check_button_toggled(button_pressed):
	if button_pressed:
		buttons.hide()
		titles.hide()
		play_button.hide()
	else:
		buttons.show()
		titles.show()
		play_button.show()
