extends Node2D

@onready var playback = $playback
@onready var scriptboard = $scriptboard
@onready var playbackcam = $playback/playbackcam
@onready var scriptboardcam = $scriptboard/scriptboardcam

var debug_mode = true

# Called when the node enters the scene tree for the first time.
func _ready():
	go_to_scriptboard()
	MM.instantiate_level(LM.level_example)
	MM.error_message_closed.connect(handle_close_message)

func go_to_playback():
	playbackcam.enabled = true
	scriptboardcam.enabled = false
	
func go_to_scriptboard():
	playbackcam.enabled = false
	scriptboardcam.enabled = true
	
func handle_close_message():
	go_to_scriptboard()
