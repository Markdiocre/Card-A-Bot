extends TextureButton

var mute_icon = preload("res://assets/mute.png")
var unmute_icon = preload("res://assets/muted.png")

func _ready():
	if BgPlayer.playing:
		button_pressed = false
	else:
		button_pressed = true



func _on_toggled(button_pressed):
	if button_pressed:
		BgPlayer.playing = false
	else:
		BgPlayer.playing = true
