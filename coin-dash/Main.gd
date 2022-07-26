extends Node

export (PackedScene) var coin
export (int) var play_time

var level
var score
var time_left
var screen_size
var playing = false

func _ready():
	randomize()
	screen_size = get_viewport().get_visible_rect().size
	$Player.screen_size = screen_size
	$Player.hide()

func new_game():
	playing = true
	level = 1
	score = 0
	time_left = play_time
	$Player.start($PlayerStart.position)
	$Player.show()
	$GameTimer.start()
	spawn_coins()
	$HUD.update_score(score)
	$HUD.update_time(time_left)
	
func spawn_coins():
	for i in range(4 + level):
		var c = coin.instance()
		$CoinContainer.add_child(c)
		c.position = Vector2(rand_range(0, screen_size.x), rand_range(0, screen_size.y))

func _process(delta):
	if playing and $CoinContainer.get_child_count() == 0:
		level += 1
		time_left += 5
		spawn_coins()


func _on_GameTimer_timeout():
	time_left -= 1
	$HUD.update_time(time_left)
	if time_left <= 0:
		game_over()
		
func _on_Player_pickup():
	score += 1
	$HUD.update_score(score)

func _on_Player_hurt():
	game_over()
		
func game_over():
	playing = false
	$GameTimer.stop()
	for coin in $CoinContainer.get_children():
		coin.queue_free()
	$HUD.show_game_over()
	$Player.die()

func _on_HUD_start_game():
	new_game()
