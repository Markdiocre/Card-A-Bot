extends Node2D

@onready var playback = $playback
@onready var scriptboard = $scriptboard
@onready var playbackcam = $playback/playbackcam
@onready var scriptboardcam = $scriptboard/scriptboardcam

# Called when the node enters the scene tree for the first time.
func _ready():
	#Activate specific cam on level load
	playbackcam.enabled = false
	scriptboardcam.enabled = true


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass