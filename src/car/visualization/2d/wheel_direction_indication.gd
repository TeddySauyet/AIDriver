extends Node2D


var velocity : Vector2 = Vector2(1,0)

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _draw():
	draw_line(Vector2(0,0),velocity,Color.BLUE,-1.0)
