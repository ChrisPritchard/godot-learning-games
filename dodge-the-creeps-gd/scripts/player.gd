extends Area2D

@export var speed = 400
var screen_size
var direction = 0

signal hit

# Called when the node enters the scene tree for the first time.
func _ready():
	print("hello world")
	screen_size = get_viewport_rect().size
	hide()
	
func start(pos):
	position = pos
	$CollisionShape2D.disabled = false
	show()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var velocity = update_direction()

	if velocity.length() > 0:
		velocity = velocity.normalized() * speed
		update_animation(velocity)
	else:
		$AnimatedSprite2D.stop()
		
	position += velocity * delta
	position = position.clamp(Vector2.ZERO, screen_size)

func update_direction():
	var velocity = Vector2.ZERO
	if Input.is_action_pressed("ui_left"):
		direction = 3
		velocity.x -= 1
	if Input.is_action_pressed("ui_right"):
		direction = 1
		velocity.x += 1
	if Input.is_action_pressed("ui_up"):
		direction = 0
		velocity.y -= 1
	if Input.is_action_pressed("ui_down"):
		direction = 2
		velocity.y += 1
	return velocity

func update_animation(velocity):
	var animation = "up"
	if direction == 1 or direction == 3:
		animation = "walk"
	
	$AnimatedSprite2D.flip_v = direction == 2
	$AnimatedSprite2D.flip_h = direction == 3
	$AnimatedSprite2D.play(animation)

func _on_body_entered(body):
	hide()
	hit.emit()
	$CollisionShape2D.set_deferred("disabled", true)
