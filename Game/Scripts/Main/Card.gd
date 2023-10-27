
class_name Card
extends Node2D

enum CardState {
	IN_HAND,
	FOCUS_IN_HAND,
	PLACED
}

var state = null
# Represents the cursor's position relative to the card origin when drag was initiated
var _drag_offset: Vector2
# Used for animating the card.
var _target_position: Vector2
var _target_rotation: float

var CARD_ROTATION

var CARD_SIZE := Vector2(48*2, 64 *2)
var NEIHGBOR_PUSH := 0.75

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func on_Card_mouse_entered()->void:
	match state:
		CardState.IN_HAND:
			pass
			
		CardState.FOCUS_IN_HAND:
			pass
			
		CardState.PLACED:
			pass

func get_my_card_index() -> int:
	if get_parent().has_method('get_card_index'):
		return(get_parent().get_card_index(self))
	else:
		return(0)

# Calculate the position that use rectangle
func _recalculate_position_use_rectangle(index_diff = null)-> Vector2:
	var card_position_x: float = 0.0
	var card_position_y: float = 0.0
	# The number of cards currently in hand
	var hand_size: int = get_parent().get_card_count()
	# The maximum of horizontal pixels we want the cards to take
	# We simply use the size of the parent control container we've defined in
	# the node settings
	var parent_control = get_parent().get_node('Control')
	var max_hand_size_width: float = parent_control.rect_size.x
	# The maximum distance between cards
	# We base it on the card width to allow it to work with any card-size.
	var card_gap_max: float = CARD_SIZE.x * 1.1
#	# The minimum distance between cards
#	# (less than card width means they start overlapping)
	var card_gap_min: float = CARD_SIZE.x/2
#	# The current distance between cards.
#	# It is inversely proportional to the amount of cards in hand
	var cards_gap: float = max(min((max_hand_size_width
			- CARD_SIZE.x/2)
			/ hand_size, card_gap_max), card_gap_min)
#	# The current width of all cards in hand together
	var hand_width: float = (cards_gap * (hand_size-1)) + CARD_SIZE.x
#	# The following just create the vector position to place this specific card
#	# in the playspace.
	card_position_x = (max_hand_size_width/2
			- hand_width/2
			+ cards_gap
			* get_my_card_index())
#	# Since our control container has the same size as the cards,we start from 0
#	# and just offset the card if we want it higher or lower.
	card_position_y = 0
	if index_diff!=null:
		return(Vector2(card_position_x, card_position_y)
				+ Vector2(CARD_SIZE.x / index_diff * NEIHGBOR_PUSH, 0))
	else:
		return(Vector2(card_position_x,card_position_y))

	return Vector2(1,1)

func recalculate_position(index_diff = null) -> Vector2:
	return _recalculate_position_use_rectangle(index_diff)

func move_to(targetHost: Node):
	var parentHost = get_parent()
	
	
	if targetHost != parentHost:
		var previous_pos = global_position
		var global_pos = global_position
		
		var parent_scale: Vector2
		var target_scale: Vector2
		if parentHost as Control:
			parent_scale = parentHost.rect_scale
		else:
			parent_scale = parentHost.scale
		if targetHost as Control:
			target_scale = targetHost.rect_scale
		else:
			target_scale = targetHost.scale
		if parent_scale > target_scale:
			scale = parent_scale / target_scale
		elif parent_scale < target_scale:
			scale *= parent_scale * target_scale
			
		global_position = previous_pos
		if targetHost.is_in_group("hands"):
			previous_pos = targetHost.to_local(global_pos)
			_target_position = recalculate_position()
			CARD_ROTATION = 0
			_target_rotation = CARD_ROTATION
			
