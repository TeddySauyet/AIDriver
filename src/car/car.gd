class_name Car
extends CharacterBody2D

var acceleration : float = 0.64*5
var drag : float = 0.05

var turn_sensitivity : float = PI/3.0


func _process(delta: float) -> void:
	var turn = Input.get_axis('a','d') * turn_sensitivity * delta
	transform = transform.rotated_local(turn)
	
	var input_accel : float = Input.get_axis("s","w") * delta * acceleration

	var drag : float = velocity.length_squared() * drag * delta
	velocity += input_accel * transform.x
	velocity -= drag * velocity.normalized()
	move_and_collide(velocity)
	print(velocity.length())
