extends Control
# Called when the node enters the scene tree for the first time.

func _on_start_pressed():
	get_tree().change_scene_to_file("res://Menu/LevelSelector.tscn")

func _on_exit_pressed():
	get_tree().quit()
	
func _notification(what):
	if what == NOTIFICATION_WM_CLOSE_REQUEST:
		get_tree().quit() # default behavior


func _on_how_pressed():
	get_tree().change_scene_to_file("res://Menu/HowTo.tscn")
