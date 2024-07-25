class_name Wheel

## This class models a single wheel responsible for a particular mass

## Wheel parameters

## the mass in kg pushing down on this wheel (straight down)
@export var mass : float = 1.0
## friction coefficients
@export var static_friction : float = 0.9
@export var rolling_friction : float = 0.01
@export var kinetic_friction : float = 0.5
## the value of gravity. m/s
var gravity : float = ProjectSettings.get_setting("physics/2d/default_gravity")

## state variables

## tire speed - tangetial speed of the tire
var tire_speed : float = 0.0 #not implemented yet
## angle of the wheel wrt to the velocity (0 = aligned perfectly, radians)
var angle : float = 0.0

## returns the current force (not normalized for delta or anything)
## current_velocity (v_forward, v_sideways)
## applied torque - positive for driving forward
## applied braking is > 0
func calculate_response_force(velocity : Vector2, 
		driving_force : float, applied_braking : float) -> Vector2:
	var orientation := Vector2(1,0).rotated(angle)
	var transverse_direction := Vector2(1,0).rotated(90+angle)
	var transverse_force := velocity.project(transverse_direction)
	var drifting : bool = transverse_force.length() > static_friction*mass*gravity
	if drifting:
		var friction := -velocity.normalized() * mass*gravity*kinetic_friction
		#do this later probably
		#var wheel_inertia_force := orientation * 
		return friction
	else:
		var friction := -orientation * mass * gravity * rolling_friction
		var driving := orientation * driving_force
		var braking = -orientation * abs(applied_braking)
		return transverse_force + friction + driving+braking
	
