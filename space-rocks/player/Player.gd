extends RigidBody2D

enum {INIT, ALIVE, INVULNERABLE, DEAD}
var state = null

export (int) var engine_power = 500
export (int) var spin_power = 15000

var thrust = Vector2()
var rotation_dir = 0

func _ready():
	change_state(ALIVE)

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
		
func _physics_process(_delta):
	set_applied_force(thrust.rotated(rotation))
	set_applied_torque(spin_power * rotation_dir)
