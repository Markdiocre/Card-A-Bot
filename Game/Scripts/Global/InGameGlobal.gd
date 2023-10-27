extends Node

var is_dragging = false
var card_being_dragged : Card = null
var card_definitions


signal new_card_instanced(Card)

func instance_card(card_name:String)->Card:
	var template = load(GContstants.CARD_PATHS + card_name + '.tscn')
	var card = template.instance()
	return card
