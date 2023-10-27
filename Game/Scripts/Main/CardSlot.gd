extends StaticBody2D


# Called when the node enters the scene tree for the first time.
func _ready():
	modulate = Color(Color.AQUAMARINE, 0.7)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if InGameGlobal.is_dragging:
		visible = true
	else:
		visible = false
