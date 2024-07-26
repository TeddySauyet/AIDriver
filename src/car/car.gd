class_name Car
extends RigidBody2D

@onready var wheel_df : Wheel = %Wheel_DF
@onready var wheel_dl : Wheel = %Wheel_DR
@onready var wheel_pf : Wheel = %Wheel_PF
@onready var wheel_pr : Wheel = %Wheel_PR

var driving_force : float = 100
var braking_force : float = 200

var wasd_turn_angle := 10 * PI/180.0

var drag : float = 0.010

@onready var wheels : Array[Wheel] = [wheel_df,wheel_dl,wheel_pf,wheel_pr]


func _physics_process(delta):
	var driving = Input.get_action_strength('w') * driving_force
	driving -= Input.get_action_strength("backup") * driving_force
	var braking = Input.get_action_strength('s') * braking_force
	var turn = Input.get_axis('a','d')
	
	var vel_for_wheel = linear_velocity.rotated(-transform.x.angle())
	
	var total_forces = []
	
	%Wheel_DF.angle = turn * wasd_turn_angle
	%Wheel_PF.angle = turn * wasd_turn_angle
	
	#print(turn)
	
	for wheel in wheels:
		var f := wheel.get_response_force(vel_for_wheel,driving,braking)
		f = f.rotated(transform.x.angle())
		total_forces.push_back(f)
	for idx in [0,1,2,3]:
		apply_force(total_forces[idx],wheels[idx].transform.origin)
	
	apply_force(-linear_velocity.normalized()*drag*linear_velocity.length_squared())
	#apply_torque(10)
	#transform = transform.rotated_local(0.01)
	#print(transform)
	#print(angular_velocity)
	print(transform.x.angle())
