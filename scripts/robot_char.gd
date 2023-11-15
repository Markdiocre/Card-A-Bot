extends CharacterBody2D

@onready var animation_player = $AnimationPlayer

enum CHAR_STATE {
	IDLE,
	WALKING,
	PAUSED
}

var state : CHAR_STATE

func set_state(st):
	state = st

func _ready():
	set_state(CHAR_STATE.IDLE)

func _physics_process(delta):
	match  state:
		CHAR_STATE.IDLE:
			animation_player.play("idle")
		CHAR_STATE.WALKING:
			animation_player.play("walking")
		CHAR_STATE.PAUSED:
			animation_player.pause()
