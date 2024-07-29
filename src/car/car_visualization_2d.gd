class_name car_visualization_2d
extends Node2D

@export var car : Car

# Called when the node enters the scene tree for the first time.
func _ready():
	$wheel_visualization.wheel = car.wheel_df
	$wheel_visualization2.wheel = car.wheel_pf
	$wheel_visualization3.wheel = car.wheel_dr
	$wheel_visualization4.wheel = car.wheel_pr


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	transform = car.transform
