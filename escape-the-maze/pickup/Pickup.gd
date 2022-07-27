extends Area2D

var textures = {
	"coin": "res://assets/coin.png",
	"key_red": "res://assets/keyRed.png",
	"key_green": "res://assets/keyGreen.png",
	"star": "res://assets/star.png" }

var type

func _ready():
	$Tween.interpolate_property($AnimatedSprite, "scale", $AnimatedSprite.scale, $AnimatedSprite.scale * 3, 0.3, Tween.TRANS_QUAD, Tween.EASE_IN_OUT)
	$Tween.interpolate_property($AnimatedSprite, "modulate", Color(1, 1, 1, 1), Color(1, 1, 1, 0), 0.3, Tween.TRANS_QUAD, Tween.EASE_IN_OUT)
	
func init(_type, pos):
	$Sprite.texture = load(textures[_type])
	type = _type
	position = pos
	
func pickup():
	$CollisionShape2D.disabled = true
	$Tween.start

func _on_Tween_tween_completed(object, key):
	queue_free()