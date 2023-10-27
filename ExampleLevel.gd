extends Node2D

func _ready():
	LoadLevel.instantiate_level("res://ExampleLevel.json")
	print(LoadLevel.OUTPUTS)
