extends RigidBody2D

var wheel : Wheel = preload("res://src/car/wheel.gd").new()

var weight : float = 1.0

var driving_force : float = 100
var braking_force : float = 200
var direction : float = 0.0 #radians

var turn_angle : float = 45 * PI/180

@onready var label : Label = $Label

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
	#$Label.position = -global_position


func _physics_process(delta):
	var driving = Input.get_action_strength('w') * driving_force
	var braking = Input.get_action_strength('s') * braking_force
	var turn = Input.get_axis('a','d')
	wheel.angle = turn * turn_angle
	var orientation := Vector2(1,0).rotated(direction)
	var vel := Vector2(linear_velocity.project(orientation).length(),linear_velocity.project(orientation.rotated(PI/2)).length())
	var force = wheel.get_response_force(vel,driving,braking)
	apply_force(force)
	direction = linear_velocity.angle()
	label.text = str(direction)
	
	#transform = transform.looking_at(transform.origin + linear_velocity)
