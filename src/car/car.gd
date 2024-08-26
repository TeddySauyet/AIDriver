class_name Car
extends CharacterBody2D

var max_speed := 15.0
var acceleration : float = 3.0

var drag_coeff : float = 0.0 #edited in ready
var turn_sensitivity : float = PI/2.0

var max_acceleration_before_drift := 0.3
var drift_drag := 0.0
var max_drift_acceleration := 10.
var regain_control_drag_accel := 0.1

enum State {
	NORMAL,
	DRIFTING,
}

var state : State = State.NORMAL

func _ready() -> void:
	drag_coeff = acceleration/max_speed**2

func _process(delta: float) -> void:
	var net_acceleration : Vector2 = Vector2.ZERO
	var drag : Vector2 = Vector2.ZERO
	match state:
		State.NORMAL:
			var turn = Input.get_axis('a','d') * turn_sensitivity * delta
			transform = transform.rotated_local(turn)
			net_acceleration = velocity.length() * transform.x - velocity
			
			var input_accel : float = Input.get_axis("s","w") * delta * acceleration
			drag = -velocity.length_squared() * drag_coeff * delta*velocity.normalized()
			net_acceleration += input_accel * transform.x + drag
			
			#velocity += net_acceleration
			if net_acceleration.length() > max_acceleration_before_drift:
				state = State.DRIFTING
		State.DRIFTING:
			drag= -velocity.length_squared() * drift_drag * delta*velocity.normalized()
			
			#var turn = Input.get_axis('a','d') * turn_sensitivity * delta
			#transform = transform.rotated_local(turn)
			#net_acceleration = velocity.length() * transform.x - velocity
			
			var turn = Input.get_axis('a','d') * turn_sensitivity * delta
			var desired_transform := transform.rotated_local(turn)
			var desired_acceleration = velocity.length() * desired_transform.x - velocity
			var factor := clampf(desired_acceleration.length(), 0,max_drift_acceleration)
			net_acceleration += desired_acceleration.normalized() * factor
			
			net_acceleration += drag
			
			#if drag.length() <= regain_control_drag_accel:
			if factor >= max_drift_acceleration:
				state = State.NORMAL
	
	var s = '|'
	print(net_acceleration.length(),s,state,s,velocity.length(),s,drag_coeff)
	velocity += net_acceleration	
	move_and_collide(velocity)
	
