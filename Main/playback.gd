extends Control

@onready var error_ui = $errorUI

@onready var error_message = $errorUI/Panel/error_message
@onready var close_button = $errorUI/Panel/close_button
@onready var v_box_container = $cmd/Panel/ScrollContainer/VBoxContainer


var line = preload("res://instantiables/line.tscn")


var play_speed = 1

var button_messages = [
	"Aww man!",
	"Got it!",
	"OKKK",
	"Worth the try"
]

func _ready():
	error_ui.hide()
	MM.print_error.connect(display_error_message)
	MM.insert_line.connect(insert_line)
	MM.simulation_started.connect(start_simulation)

func start_simulation():
	for i in v_box_container.get_children():
		i.queue_free()
	
func insert_line(message, type):
	var new_line = line.instantiate()
	new_line.text = message
	
	match type:
		"error":
			new_line.add_theme_color_override("font_color", Color.RED)
		"start":
			new_line.add_theme_color_override("font_color", Color.DARK_BLUE)
		"normal":
			new_line.add_theme_color_override("font_color", Color.WHITE)
		"note":
			new_line.add_theme_color_override("font_color", Color.YELLOW)
	
	v_box_container.add_child(new_line)

func display_error_message(message: String):
	close_button.text = button_messages[randi_range(0, button_messages.size()-1)]
	error_ui.show()
	error_message.text = message

func _on_close_button_pressed():
	error_ui.hide()
	MM.emit_signal("error_message_closed")
	
