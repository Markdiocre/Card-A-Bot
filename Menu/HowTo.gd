extends Control
@onready var mechanics = $cams/mechanics
@onready var scriptboard = $cams/scriptboard
@onready var playback = $cams/playback

#var cameras : Array[Camera2D] = [mechanics, scriptboard, playback]

#Scriptboard part
@onready var buttons = $new_main/scriptboard/Buttons

func _ready():
	mechanics.enabled = true


func _on_mechs_next_pressed():
	mechanics.enabled = false
	playback.enabled = true


func _on_playback_next_pressed():
	playback.enabled = false
	scriptboard.enabled = true


func _on_scriptboard_next_pressed():
	get_tree().change_scene_to_file("res://Menu/MainMenu.tscn")
