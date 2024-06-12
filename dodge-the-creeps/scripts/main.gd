extends Node

@export var creep_scene: PackedScene
var score

func new_game():
	score = 0
	$Player.start($StartPosition.position)
	$StartTimer.start()
	$BackgroundMusic.play()
	
func game_over():
	$ScoreTimer.stop()
	$CreepTimer.stop()
	$BackgroundMusic.stop()
	$GameOverSound.play()
	get_tree().call_group("creeps", "queue_free")

func _on_start_timer_timeout():
	$ScoreTimer.start()
	$CreepTimer.start()

func _on_score_timer_timeout():
	score += 1
	$UserInterface.set_score(score)

func _on_creep_timer_timeout():
	var spawn = $CreepPath/CreepSpawn
	spawn.progress_ratio = randf()
	
	var creep = creep_scene.instantiate()
	creep.position = spawn.position
	creep.rotation = (spawn.rotation + PI / 2) + randf_range(-PI/4, PI/4)
	creep.linear_velocity = Vector2(randf_range(150.0, 250.0), 0.0).rotated(creep.rotation)
	add_child(creep)

func _on_player_hit():
	game_over()
	$UserInterface.show_game_over()

func _on_user_interface_start_game():
	new_game()
