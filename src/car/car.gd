class_name Car
extends CharacterBody2D

@onready var wheel_df : Wheel = %Wheel_DF
@onready var wheel_dr : Wheel = %Wheel_DR
@onready var wheel_pf : Wheel = %Wheel_PF
@onready var wheel_pr : Wheel = %Wheel_PR

var driving_force : float = 20000
var braking_force : float = 200000
var mass = 400.0
var angular_inertia = 40000.0

var wasd_turn_angle := 20 * PI/180.0

var drag : float = 0.1

@onready var wheels : Array[Wheel] = [wheel_df,wheel_dr,wheel_pf,wheel_pr]
@onready var front_wheels : Array[Wheel] = [wheel_df,wheel_pf]
@onready var back_wheels : Array[Wheel] = [wheel_dr,wheel_pr]


var linear_velocity : Vector2 = Vector2.ZERO
var angular_velocity : float = 0.0

func _physics_process(delta):
	var driving = Input.get_action_strength('w') * driving_force
	driving -= Input.get_action_strength("backup") * driving_force
	var braking = Input.get_action_strength('s') * braking_force
	var turn = Input.get_axis('a','d')
	
	var vel_for_wheel = linear_velocity.rotated(-transform.x.angle())
	
	var total_forces : Array[Vector2] = []
	var locations: Array[Vector2] = []
	#print(turn)
	
	#print(angular_velocity,linear_velocity)
	
	for wheel in front_wheels:
		var perp_velocity := wheel.transform.origin.rotated(PI/2).rotated(-transform.x.angle())*angular_velocity
		wheel.mass = mass/4
		wheel.angle = turn * wasd_turn_angle
		var f := wheel.get_response_force(vel_for_wheel+perp_velocity,0.0,braking)
		f = f.rotated(transform.x.angle())
		total_forces.push_back(f)
		locations.push_back(wheel.global_position - global_position)
	
	for wheel in back_wheels:
		wheel.mass = mass/4
		var perp_velocity := wheel.transform.origin.rotated(PI/2).rotated(-transform.x.angle())*angular_velocity
		
		var f := wheel.get_response_force(vel_for_wheel+perp_velocity,driving,braking)
		f = f.rotated(transform.x.angle())
		total_forces.push_back(f)
		locations.push_back(wheel.global_position - global_position)
	
	var s = '|'
	for f in total_forces:
		s = s + str(f.angle()*180/PI) + ',' + str(f.length()) + '|'
	#print(transform.x.angle()*180/PI,'|',linear_velocity.angle()*180/PI,s)
	#print(s)
	var total_force := Vector2.ZERO
	var total_torque := 0.0
	
	
	for idx in [0,1,2,3]:
		#apply_force(total_forces[idx],locations[idx])
		total_force += total_forces[idx]
		var ortho_dir : Vector2 = locations[idx].rotated(PI/2)
		var ortho_force : Vector2 = total_forces[idx].project(ortho_dir)
		var t : float = ortho_force.length() * sign(ortho_force.dot(ortho_dir))
		total_torque += t
		#print(idx,':',t,'|',locations[idx],total_forces[idx],locations[idx].rotated(PI/2),total_forces[idx].project(locations[idx].rotated(PI/2)),total_forces[idx].project(locations[idx].rotated(PI/2)).length())
		
	
	if total_torque != 0:
		pass
	rotation += total_torque/angular_inertia
	linear_velocity += total_force/mass*delta
	move_and_collide(linear_velocity*delta)
	
	#apply_force(-linear_velocity.normalized()*drag*linear_velocity.length_squared())
	#apply_torque(10)
	#transform = transform.rotated_local(0.01)
	#print(transform)
	#print(angular_velocity)
