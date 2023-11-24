extends CanvasLayer

@onready var animation_player = $AnimationPlayer

func do_transition():
	animation_player.play("fade_in")
	await animation_player.animation_finished
	animation_player.play_backwards("fade_in")
	MM.run_simulation()
	
