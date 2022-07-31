extends KinematicBody2D

enum {IDLE,RUN,JUMP,HURT,DEAD}
var state
var anim
var new_anim

func ready():
	change_state(IDLE)
	
func change_state(new_state):
	state = new_state
	match state:
		IDLE:
			new_anim = "idle"
		RUN:
			new_anim = "run"
		HURT:
			new_anim = "hurt"
		JUMP:
			new_anim = "jump_up"
		DEAD:
			hide()
	
func _physics_process(delta):
	if new_anim != anim:
		anim = new_anim
		$AnimatedSprite.play(anim)
