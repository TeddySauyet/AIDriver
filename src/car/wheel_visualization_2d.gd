class_name wheel_visualization_2d
extends Sprite2D

@export var wheel : Wheel

func _process(delta: float) -> void:
	rotation = wheel.angle
	if wheel.drifting:
		texture.gradient.colors = PackedColorArray([Color(0,0,0), Color(1,0,0)])
	else:
		texture.gradient.colors = PackedColorArray([Color(0,0,0), Color(1,1,1)])
	transform = wheel.transform

func _ready() -> void:
	texture = GradientTexture1D.new()
	texture.gradient = Gradient.new()
	texture.width = 16
