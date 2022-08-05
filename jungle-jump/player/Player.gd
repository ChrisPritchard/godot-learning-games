extends KinematicBody2D

signal life_changed
signal dead

var life

export (int) var run_speed = 100
export (int) var jump_speed = -100
export (int) var gravity = 100

enum {IDLE,RUN,JUMP,HURT,DEAD}
var state
var anim
var new_anim
var velocity = Vector2()

var max_jumps = 2
var jump_count = 0

func start(pos):
	position = pos
	life = 3
	emit_signal("life_changed", life)
	show()
	change_state(IDLE)

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
			$HurtSound.play()
			print("player hurt - life %s" % life)
			new_anim = "hurt"
			velocity.y = -80
			velocity.x = -40 * sign(velocity.x)
			life -= 1
			emit_signal("life_changed", life)
			yield(get_tree().create_timer(1), "timeout")
			change_state(IDLE)
			if life <= 0:
				change_state(DEAD)
		JUMP:
			new_anim = "jump_up"
			jump_count = 1
		DEAD:
			emit_signal("dead")
			hide()

func get_input():
	if state == HURT:
		return
	
	var right = Input.is_action_pressed("right")
	var left = Input.is_action_pressed("left")
	var jump = Input.is_action_just_pressed("jump")
	
	velocity.x = 0
	if right:
		velocity.x += run_speed
		$AnimatedSprite.flip_h = false
	if left:
		velocity.x -= run_speed
		$AnimatedSprite.flip_h = true
		
	if jump and state == JUMP and jump_count < max_jumps:
		$JumpSound.play()
		new_anim = "jump_up"
		velocity.y = jump_speed / 1.5
		jump_count += 1
	elif jump and is_on_floor():
		$JumpSound.play()
		change_state(JUMP)
		velocity.y = jump_speed
		
	if state == IDLE and velocity.x != 0:
		change_state(RUN)
	if state == RUN and velocity.x == 0:
		change_state(IDLE)
	if state in [IDLE,RUN] and !is_on_floor():
		change_state(JUMP)
	
func _physics_process(delta):
	if position.y > 1000:
		change_state(DEAD)
		return
	
	velocity.y += gravity * delta
	get_input()
	if new_anim != anim:
		anim = new_anim
		$AnimatedSprite.play(anim)
	velocity = move_and_slide(velocity, Vector2(0, -1))
	if state == HURT:
		return
	for idx in range(get_slide_count()):
		var collision = get_slide_collision(idx)
		if collision.collider.name == "Danger":
			hurt()
		if collision.collider.is_in_group("enemies"):
			var player_feet = (position + $CollisionShape2D.shape.extents).y
			if player_feet < collision.collider.position.y:
				collision.collider.take_damage()
				velocity.y = -80
			else:
				hurt()
	if state == JUMP and is_on_floor():
		change_state(IDLE)
		$Dust.emitting = true
	if state == JUMP and velocity.y > 0:
		new_anim = "jump_down"

func hurt():
	if state != HURT:
		change_state(HURT)
