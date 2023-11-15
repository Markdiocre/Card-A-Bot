extends Node2D

@onready var robot_char = $robot_char
@onready var inp_marker = $markers/inp_marker
@onready var start_marker = $markers/start_marker
@onready var out_marker = $markers/out_marker
@onready var error_ui = $errorUI

@onready var error_message = $errorUI/Panel/error_message
@onready var close_button = $errorUI/Panel/close_button

var play_speed = 1

func _ready():
	error_ui.hide()
	MM.print_error.connect(display_error_message)
	MM.simulation_started.connect(reset_to_start)

func display_error_message(message: String):
	error_ui.show()
	error_message.text = message
	robot_char.set_state(robot_char.CHAR_STATE.PAUSED)

func reset_to_start():
	robot_char.position = start_marker.position
	robot_char.set_state(robot_char.CHAR_STATE.IDLE)

func _on_close_button_pressed():
	error_ui.hide()
	MM.emit_signal("error_message_closed")
	

