extends CanvasLayer

signal start_game

func show_game_over():
	$Message.text = "Game Over!"
	$Message.show()
	await get_tree().create_timer(1.).timeout
	
	$Message.text = "Dodge the Creeps!"
	$Message.show()
	
	await get_tree().create_timer(1.).timeout
	$StartButton.show()
	
func set_score(score):
	$Score.text = str(score)
	
func _on_start_button_pressed():
	$StartButton.hide()
	$Message.hide()
	$Score.text = "0"
	start_game.emit()

	$Message.text = "Get Ready..."
	$Message.show()
	await get_tree().create_timer(1.).timeout
	$Message.hide()
