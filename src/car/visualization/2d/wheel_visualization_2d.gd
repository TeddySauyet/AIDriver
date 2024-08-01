class_name wheel_visualization_2d
extends Sprite2D

@export var wheel : Wheel

func _process(delta: float) -> void:
	if wheel.drifting:
		texture.gradient.colors = PackedColorArray([Color(0,0,0), Color(1,0,0)])
	else:
		texture.gradient.colors = PackedColorArray([Color(0,0,0), Color(1,1,1)])
	transform = wheel.transform
	rotation = wheel.angle
	scale = Vector2(1,7)
	$WheelDirectionIndication.velocity = wheel.forced_velocity
	$WheelDirectionIndication.queue_redraw()
	#position = Vector2(Time.get_ticks_msec()/10,0)
	#$Sprite2D.position = Vector2(16,0)
	#$Sprite2D.rotation = wheel.forced_velocity.angle() - rotation
	#var x = Vector2(1,10)
	#$Sprite2D.scale = x
	#$Sprite2D.rotation = Time.get_ticks_msec()/1000.0
	#$Sprite2D.position = Vector2(16,0)
	#$Sprite2D.texture.gradient.colors = PackedColorArray([Color(0,0,0), Color(0,0,1)])
	#$Sprite2D.global_scale = Vector2(1,2).rotated(-$Sprite2D.global_rotation)
	#print($Sprite2D.global_scale,$Sprite2D.global_rotation)
	

func _ready() -> void:
	texture = GradientTexture1D.new()
	texture.gradient = Gradient.new()
	texture.width = 16
	scale = Vector2(1,7)
	##
	#$Sprite2D.texture = GradientTexture1D.new()
	#$Sprite2D.texture.gradient = Gradient.new()
	#$Sprite2D.texture.width = 32
	#$Sprite2D.scale = Vector2(1,7)
