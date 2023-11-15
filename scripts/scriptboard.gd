extends Control

@onready var button_vert = $Buttons/BoxContainer/ButtonVert
@onready var counter_vert = $Buttons/BoxContainer/CounterVert
@onready var visualboard = $visualboard

# Called when the node enters the scene tree for the first time.
func _ready():
	pass

func _on_play_button_pressed():
	get_parent().go_to_playback()
	MM.run_simulation()
