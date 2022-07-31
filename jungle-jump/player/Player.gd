extends KinematicBody2D

export (int) var run_speed
export (int) var jump_speed
export (int) var gravity

enum {IDLE,RUN,JUMP,HURT,DEAD}
var state
var anim
var new_anim
var velocity = Vector2()

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

func get_input():
	if state == HURT:
		return
	
	var right = Input.is_action_pressed("right")
	var left = Input.is_action_pressed("left")
	var jump = Input.is_action_just_pressed("jump")
	
	if right:
		velocity.x += run_speed
		$AnimatedSprite.flip_h = false
	if left:
		velocity.x -= run_speed
		$AnimatedSprite.flip_h = false
		
	if jump and is_on_floor():
		change_state(JUMP)
		velocity.y = jump_speed
		
	if state == IDLE and velocity.x != 0:
		change_state(RUN)
	if state == RUN and velocity.x == 0:
		change_state(IDLE)
	if state in [IDLE,RUN] and !is_on_floor():
		change_state(JUMP)
	
func _physics_process(delta):
	velocity.y += gravity * delta
	get_input()
	if new_anim != anim:
		anim = new_anim
		$AnimatedSprite.play(anim)
	velocity = move_and_slide(velocity, Vector2(0, -1))
	if state == JUMP and is_on_floor():
		change_state(IDLE)
	if state == JUMP and velocity.y > 0:
		new_anim = "jump_down"
