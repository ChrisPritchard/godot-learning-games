extends Node

var levels = [
	"res://levels/Level1.tscn",
	"res://levels/Level2.tscn" ]
	
var current_level

var start_screen = "res://ui/StartScreen.tscn"
var end_screen = "res://ui/EndScreen.tscn"

func new_game():
	current_level = -1
	next_level()
	
func game_over():
	get_tree().change_scene(end_screen)
	
func next_level():
	current_level += 1
	if current_level >= Global.levels.size():
		game_over()
	else:
		get_tree().change_scene(levels[current_level])
