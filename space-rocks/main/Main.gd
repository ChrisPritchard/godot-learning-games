extends Node

export (PackedScene) var Rock

var screensize

func _ready():
	randomize()
	screensize = get_viewport().get_visible_rect().size
	$Player.screensize = screensize
	for i in range(3):
		spawn_rock(3)
		
func spawn_rock(size, pos=null, vel=null):
	if !pos:
		$RockPath/RockSpawn.set_offset(randi())
		pos = $RockPath/RockSpawn.position
	if !vel:
		vel = Vector2(1, 0).rotated(rand_range(0, 2*PI)) * rand_range(100, 150)
	var r = Rock.instance()
	r.screensize = screensize
	r.start(pos, vel, size)
	r.connect("exploded", self, "_on_Rock_exploded")
	$Rocks.add_child(r)

func _on_Player_shoot(bullet, pos, dir):
	var b = bullet.instance()
	b.start(pos, dir)
	add_child(b)

func _on_Rock_exploded(size, radius, pos, vel):
	if size <= 1:
		return
	for offset in [-1, 1]:
		var dir = (pos - $Player.position).normalized().tangent() * offset
		var newpos = pos + dir * radius
		var newvel = dir * vel.length() * 1.1
		spawn_rock(size - 1, newpos, newvel)
