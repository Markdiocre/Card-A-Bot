class_name Hand
extends Area2D

enum Anchors {
	NONE,
	TOP_RIGHT,
	TOP_MIDDLE,
	TOP_LEFT,
	RIGHT_MIDDLE,
	LEFT_MIDDLE,
	BOTTOM_RIGHT,
	BOTTOM_MIDDLE,
	BOTTOM_LEFT,
	CONTROL,
}

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


	
	
func get_all_cards() -> Array:
	var cardsArray := []
	
	for obj in get_children():
		# Remove dragged cards as children 
		if not obj is Card:
			continue
		if not is_instance_valid(obj):
			continue
		if obj == InGameGlobal.card_being_dragged:
			continue
		
		cardsArray.append(obj)
	
	return cardsArray
	
# Returns an int with the amount of children nodes which are of Card class
func get_card_count() -> int:
	return(get_all_cards().size())


# Returns a card object of the card in the specified index among all cards.
func get_card(idx: int) -> Card:
	if idx < 0:
		return(null)
	return(get_all_cards()[idx])

# Returns an int of the index of the card object requested
func get_card_index(card: Card) -> int:
	return get_all_cards().find(card)

# Returns true if this card container has a Card object matching the specified one
func has_card(card: Card) -> bool:
	if card in get_all_cards():
		return(true)
	return(false)
	
func draw_card(card : Card):
	card.move_to(self)
	return card
	
func re_place():
	pass

