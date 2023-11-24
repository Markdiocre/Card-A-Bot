extends Node2D

@onready var playback = $playback
@onready var scriptboard = $scriptboard
@onready var main_cam = $MainCam

var debug_mode = true

# Called when the node enters the scene tree for the first time.
func _ready():
	go_to_scriptboard()
	MM.instantiate_level(LM.level_1)
	MM.error_message_closed.connect(handle_close_message)

func go_to_playback():
	main_cam.global_position = Vector2(playback.global_position.x  + (1920 / 2), playback.global_position.y +  (1080/ 2))
	
func go_to_scriptboard():
	main_cam.global_position = Vector2(scriptboard.global_position.x  + (1920 / 2), scriptboard.global_position.y +  (1080/ 2))
	
func handle_close_message():
	go_to_scriptboard()
