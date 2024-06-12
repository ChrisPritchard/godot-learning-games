extends Node

var num_levels = 1
var current_level = 1

var game_scene = "res://main/Main.tscn"
var title_screen = "res://ui/TitleScreen.tscn"

func restart():
	get_tree().change_scene(title_screen)
	
func next_level():
	current_level += 1
	if current_level <= num_levels:
		get_tree().reload_current_scene()
	else:
		restart()
