class_name Car
extends CharacterBody2D

var acceleration : float = 0.64*5
var drag : float = 0.05
var turn_sensitivity : float = PI/3.0

var max_acceleration_before_drift := 3.0

enum State {
	NORMAL,
	DRIFTING,
}

var state : State = State.NORMAL

func _process(delta: float) -> void:
	var net_acceleration : Vector2
	var drag : Vector2 = -velocity.length_squared() * drag * delta*velocity.normalized()
	match state:
		State.NORMAL:
			var turn = Input.get_axis('a','d') * turn_sensitivity * delta
			transform = transform.rotated_local(turn)
			
			var input_accel : float = Input.get_axis("s","w") * delta * acceleration
			net_acceleration= input_accel * transform.x + drag
			
			velocity += net_acceleration

		State.DRIFTING:
			velocity += drag
	if net_acceleration.length() > max_acceleration_before_drift:
		state = State.DRIFTING
	#print(velocity.length())
	move_and_collide(velocity)
	
