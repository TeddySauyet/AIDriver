class_name Wheel
extends Node2D

## This class models a single wheel responsible for a particular mass

## Wheel parameters

## the mass in kg pushing down on this wheel (straight down)
@export var mass : float = 1.0
## friction coefficients
@export var static_friction : float = 20.0 # >0 because 2D simulation
@export var rolling_friction : float = 1
@export var kinetic_friction : float = 10.0
@export var drift_portion_drive_force : float = 0.5
## the value of gravity. m/s
var gravity : float = ProjectSettings.get_setting("physics/2d/default_gravity")

## state variables

## tire speed - tangetial speed of the tire
var tire_speed : float = 0.0 #not implemented yet
## angle of the wheel wrt to the velocity (0 = aligned perfectly, radians)
var angle : float = 0.0
##are we drifiting
var drifting : bool = false
## returns the current force (not normalized for delta or anything)
## current_velocity (v_forward, v_sideways)
## applied torque - positive for driving forward
## applied braking is > 0


func get_response_force(velocity : Vector2, 
			driving_force : float, applied_braking : float) -> Vector2:
	var orientation := Vector2(1,0).rotated(angle)
	var transverse_direction := Vector2(1,0).rotated(PI/2+angle)
	var transverse_force := -velocity.project(transverse_direction)*mass
	#var transverse_force := orientation*velocity.length() - velocity
	drifting = transverse_force.length() > static_friction*mass*gravity
	var result := Vector2.ZERO
	#print(orientation.angle(),'|',transverse_force.angle())
	if drifting:
		var friction := -velocity.normalized() * mass*gravity*kinetic_friction
		var driving := orientation * driving_force * drift_portion_drive_force
		#do this later probably
		#var wheel_inertia_force := orientation * 
		result = friction + driving
		#print('drifting')
	else:
		var friction := -velocity.project(orientation)*rolling_friction
		var driving := orientation * driving_force
		var braking := -orientation * applied_braking
		if velocity.length() < braking.length():
			braking = braking.normalized()*velocity.length()
		#print(velocity,'|',braking,'|',driving)
		#print(transverse_force,'|',friction,'|',driving,'|',braking,'|',velocity)
		result = transverse_force + friction + driving + braking
		tire_speed = velocity.length()
		#print('not drifting')
	#print(result,'|',velocity, '|',transverse_force,'|',transverse_direction,'|','|',orientation)
	return result
