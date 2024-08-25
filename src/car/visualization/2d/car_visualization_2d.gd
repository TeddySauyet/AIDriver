class_name car_visualization_2d
extends Node2D

@export var car : Car

# Called when the node enters the scene tree for the first time.



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	transform = car.transform
