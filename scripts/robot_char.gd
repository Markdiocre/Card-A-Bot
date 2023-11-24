extends CharacterBody2D

@onready var animation_player = $AnimationPlayer
@onready var char = $Char
@onready var current_value_marker = $current_value_marker

enum CHAR_STATE {
	IDLE,
	WALKING,
	PAUSED
}

var is_carrying_something = false

var state : CHAR_STATE

func set_state(st):
	state = st

func _ready():
	set_state(CHAR_STATE.IDLE)
	
func get_marker_position():
	return current_value_marker.position

func _physics_process(delta):
	if is_carrying_something:
		char.frame = 1
	else:
		char.frame = 0
		
	match  state:
		CHAR_STATE.IDLE:
			animation_player.play("idle")
		CHAR_STATE.WALKING:
			animation_player.play("walking")
		CHAR_STATE.PAUSED:
			animation_player.pause()
