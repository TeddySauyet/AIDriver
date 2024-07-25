class_name Wheel

## This class models a single wheel responsible for a particular mass

## Wheel parameters

## the mass in kg pushing down on this wheel (straight down)
@export var weight : float = 1.0
## friction coefficients
@export var static_friction : float = 0.9
@export var rolling_friction : float = 0.01
@export var kinetic_friction : float = 0.5
## the value of gravity. m/s
var gravity : float = ProjectSettings.get_setting("physics/2d/default_gravity")

## state variables

## wheel velocity, m/s
var velocity : Vector2 = Vector2.ZERO
## angle of the wheel wrt to the velocity (0 = aligned perfectly, radians)
var angle : float = 0.0
#i think that's all we need.
### how fast the wheel is spinning 
#var angular_velocity : float = 0.0
#enum FrictionMode {
	#KINETIC,
	#STATIC,
#}
#var friction_mode : FrictionMode = FrictionMode.STATIC

## returns the current force (not normalized for delta or anything)
func calculate_response_force(applied_force : Vector2) -> Vector2:
	var result : Vector2 = Vector2.ZERO
	
	#calculate transverse force
	var normal_force : float = weight * gravity
	var max_transverse_force : float = static_friction * normal_force
	var drifting : bool = max_transverse_force < applied_force.y
	if drifting:
		return applied_force - velocity.normalized() * normal_force * kinetic_friction
	else:
		var transverse_force = 
