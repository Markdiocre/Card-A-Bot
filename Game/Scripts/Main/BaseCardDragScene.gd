extends Node2D

var draggable = false
var is_inside_card_slot = false
var body_ref
var initialPos
var offset : Vector2
@onready var parentNode = get_parent()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if draggable:
		if Input.is_action_just_pressed("click"):
			initialPos = parentNode.global_position
			offset = get_global_mouse_position() - global_position

		if Input.is_action_pressed("click"):
			parentNode.global_position = get_global_mouse_position()
		elif Input.is_action_just_released("click"):
			InGameGlobal.is_dragging = false
			var tween = get_tree().create_tween()
			if is_inside_card_slot:
				tween.tween_property(parentNode,"position",body_ref.position,0.2).set_ease(tween.EASE_OUT)
			else:
				tween.tween_property(parentNode,"position",initialPos,0.2).set_ease(tween.EASE_OUT)



func _on_area_2d_body_entered(body):
	if body.is_in_group("card_slot_dropable"):
		is_inside_card_slot = true
		body.modulate = Color(Color.BLUE, 1)
		body_ref = body


func _on_area_2d_body_exited(body):
	if body.is_in_group("card_slot_dropable"):
		is_inside_card_slot = false
		body.modulate = Color(Color.AQUAMARINE, 0.7)


func _on_area_2d_mouse_entered():
	if not InGameGlobal.is_dragging:
		draggable = true
		parentNode.scale = Vector2(1.05,1.05)


func _on_area_2d_mouse_exited():
	if not InGameGlobal.is_dragging:
		draggable = false
		parentNode.scale = Vector2(1,1)
