extends "res://character/Character.gd"

signal moved
signal dead
signal grabbed_key
signal win

func _process(delta):
	if can_move:
		for dir in moves.keys():
			if Input.is_action_pressed(dir):
				if move(dir):
					emit_signal("moved")

func _on_Player_area_entered(area):
	if area.is_in_group("enemies"):
		emit_signal("dead")
	elif area.has_method("pickup"):
		area.pickup()
	elif area.type == "key_red":
		emit_signal("has_key", "red")
	elif area.type == "key_green":
		emit_signal("has_key", "green")
	elif area.type == "star":
		emit_signal("win")
