extends RigidBody2D

signal shoot
signal lives_changed
signal dead

enum {INIT, ALIVE, INVULNERABLE, DEAD}
var state = null

export (int) var engine_power = 500
export (int) var spin_power = 15000

var thrust = Vector2()
var rotation_dir = 0

var screensize = Vector2()
var radius

export (PackedScene) var Bullet
export (float) var fire_rate = 0.25

var can_shoot = true
var lives = 0 setget set_lives

func set_lives(value):
	lives = value
	emit_signal("lives_changed")

func _ready():
	change_state(ALIVE)
	$GunTimer.wait_time = fire_rate
	radius = $CollisionShape2D.shape.radius
	
func start():
	$Sprite.show()
	self.lives = 3
	change_state(ALIVE)

func change_state(new_state):
	match new_state:
		INIT:
			$CollisionShape2D.set_deferred("disabled", true)
			$Sprite.modulate.a = 0.5
		ALIVE:
			$CollisionShape2D.set_deferred("disabled", false)
			$Sprite.modulate.a = 1.0
		INVULNERABLE:
			$CollisionShape2D.set_deferred("disabled", true)
			$Sprite.modulate.a = 0.5
			$InvulnerabilityTimer.start()
		DEAD:
			$CollisionShape2D.set_deferred("disabled", true)
			$Sprite.hide()
			$EngineSound.stop()
			linear_velocity = Vector2()
			emit_signal("dead")
			
	state = new_state

func _process(_delta):
	get_input()
	
func get_input():
	thrust = Vector2()
	if state in [DEAD, INIT]:
		return
	if Input.is_action_pressed("thrust"):
		thrust = Vector2(engine_power, 0)
		if not $EngineSound.playing:
			$EngineSound.play()
	else:
		$EngineSound.stop()
	rotation_dir = 0
	if Input.is_action_pressed("rotate_right"):
		rotation_dir += 1
	if Input.is_action_pressed("rotate_left"):
		rotation_dir -= 1
	if Input.is_action_pressed("shoot") and can_shoot:
		shoot()
		
func shoot():
	if state == INVULNERABLE:
		return
	emit_signal("shoot", Bullet, $Muzzle.global_position, rotation)
	can_shoot = false
	$GunTimer.start()
	$LaserSound.play()
		
func _integrate_forces(physics_state):
	set_applied_force(thrust.rotated(rotation))
	set_applied_torque(spin_power * rotation_dir)
	var xform = physics_state.get_transform()
	if xform.origin.x > screensize.x + radius:
		xform.origin.x = 0 - radius
	if xform.origin.x < 0 - radius:
		xform.origin.x = screensize.x + radius
	if xform.origin.y > screensize.y + radius:
		xform.origin.y = 0 - radius
	if xform.origin.y < 0 - radius:
		xform.origin.y = screensize.y + radius
	physics_state.set_transform(xform)

func _on_GunTimer_timeout():
	can_shoot = true

func _on_InvulnerabilityTimer_timeout():
	change_state(ALIVE)

func _on_Explosion_animation_finished():
	$Explosion.hide()

func _on_Player_body_entered(body):
	if body.is_in_group("rocks"):
		body.explode()
		$Explosion.show()
		$Explosion.play()
		self.lives -= 1
		if lives <= 0:
			change_state(DEAD)
		else:
			change_state(INVULNERABLE)
