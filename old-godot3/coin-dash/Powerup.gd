extends Area2D

var screen_size = Vector2()

func _ready():
	$Tween.interpolate_property($AnimatedSprite, "scale", $AnimatedSprite.scale, $AnimatedSprite.scale * 3, 0.3, Tween.TRANS_QUAD, Tween.EASE_IN_OUT)
	$Tween.interpolate_property($AnimatedSprite, "modulate", Color(1, 1, 1, 1), Color(1, 1, 1, 0), 0.3, Tween.TRANS_QUAD, Tween.EASE_IN_OUT)

func pickup():
	monitoring = false
	$Tween.start()

func _on_Tween_tween_completed(object, key):
	queue_free()

func _on_Lifetime_timeout():
	queue_free()


func _on_Powerup_area_entered(area):
	if !area.is_in_group("player"):
		position = Vector2(rand_range(0, screen_size.x), rand_range(0, screen_size.y))
