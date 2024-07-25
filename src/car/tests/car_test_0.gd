extends RigidBody2D

var wheel : Wheel = preload("res://src/car/wheel.gd").new()

var weight : float = 1.0

var driving_force : float = 100
var braking_force : float = 200

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
	var force = wheel.get_response_force(linear_velocity.rotated(transform.get_rotation()),driving,braking)
	label.text = str(force)
	apply_force(force)
	transform = transform.looking_at(transform.origin + linear_velocity)
