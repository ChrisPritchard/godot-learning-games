extends Area2D

signal shoot

export (PackedScene) var Bullet
export (int) var speed = 150
export (int) var health = 3

var follow
var target = null

func _ready():
	$Sprite.frame = randi() % 3
	var path = $EnemyPath.get_children()[randi() % $EnemyPath.get_child_count()]
	follow = PathFollow2D.new()
	path.add_child(follow)
	follow.loop = false
	
func _process(delta):
	follow.offset += speed * delta
	position = follow.global_position
	if follow.unit_offset >= 1:
		queue_free()

func _on_Explosion_animation_finished():
	yield($ExplodeSound, "finished")
	queue_free()

func _on_GunTimer_timeout():
	shoot_pulse(3, 0.15)
	
func shoot_pulse(n, delay):
	for _i in range(n):
		shoot()
		yield(get_tree().create_timer(delay), "timeout")

func shoot():
	var dir = target.global_position - global_position
	dir = dir.rotated(rand_range(-0.1, 0.1)).angle()
	emit_signal("shoot", Bullet, global_position, dir)
	$ShootSound.play()

func take_damage(amount):
	health -= amount
	$Sprite/AnimationPlayer.play("flash")
	if health <= 0:
		explode()
	yield($Sprite/AnimationPlayer, "animation_finished")
	$Sprite/AnimationPlayer.play("rotate")

func explode():
	speed = 0
	$GunTimer.stop()
	$CollisionShape2D.set_deferred("disabled", true)
	$Sprite.hide()
	$Explosion.show()
	$Explosion.play()
	$ExplodeSound.play()

func _on_Enemy_body_entered(body):
	if body.name == "Player":
		pass
	explode()
