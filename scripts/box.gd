extends StaticBody2D

@onready var label = $Sprite2D/Label

func set_label(num):
	$Sprite2D/Label.text = str(num)
