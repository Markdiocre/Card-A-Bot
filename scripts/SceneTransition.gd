extends CanvasLayer

@onready var animation_player = $AnimationPlayer
var main

func find_main():
	main = get_tree().root.get_node("new_main")

func do_transition():
	animation_player.play("fade_in")
	await animation_player.animation_finished
	animation_player.play_backwards("fade_in")
	main.run_simulation()
	
