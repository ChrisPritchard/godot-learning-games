extends RigidBody2D

enum {INIT, ALIVE, INVULNERABLE, DEAD}
var state = null

export (int) var engine_power = 500
export (int) var spin_power = 15000

var thrust = Vector2()
var rotation_dir = 0

var screensize = Vector2()

func _ready():
	change_state(ALIVE)
	screensize = get_viewport().get_visible_rect().size

func change_state(new_state):
	match new_state:
		INIT:
			$CollisionShape2D.set_deferred("disabled", true)
		INIT:
			$CollisionShape2D.set_deferred("disabled", false)
		INIT:
			$CollisionShape2D.set_deferred("disabled", true)
		INIT:
			$CollisionShape2D.set_deferred("disabled", true)
	state = new_state

func _process(_delta):
	get_input()
	
func get_input():
	thrust = Vector2()
	if state in [DEAD, INIT]:
		return
	if Input.is_action_pressed("thrust"):
		thrust = Vector2(engine_power, 0)
	rotation_dir = 0
	if Input.is_action_pressed("rotate_right"):
		rotation_dir += 1
	if Input.is_action_pressed("rotate_left"):
		rotation_dir -= 1
		
func _integrate_forces(physics_state):
	set_applied_force(thrust.rotated(rotation))
	set_applied_torque(spin_power * rotation_dir)
	var xform = physics_state.get_transform()
	if xform.origin.x > screensize.x:
		xform.origin.x = 0
	if xform.origin.x < 0:
		xform.origin.x = screensize.x
	if xform.origin.y > screensize.y:
		xform.origin.y = 0
	if xform.origin.y < 0:
		xform.origin.y = screensize.y
	physics_state.set_transform(xform)
