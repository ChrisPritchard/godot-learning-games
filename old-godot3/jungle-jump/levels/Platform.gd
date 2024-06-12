extends KinematicBody2D

export (Vector2) var velocity = Vector2(50, 0)

func _physics_process(delta):
	var collision = move_and_collide(velocity * delta)
	if collision:
		velocity.x *= -1
