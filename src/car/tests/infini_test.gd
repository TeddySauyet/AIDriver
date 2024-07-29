extends Node2D


@onready var car : Car = $Car
@onready var background : Sprite2D = $BackgroundSingleCar2d
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	#background.rotation = -car.rotation
	background.material.set_shader_parameter("world_pos", car.position)
	background.position = car.position
	#background.rotat
	print(car.position)
