extends StaticBody2D

# class member variables go here, for example:
# var a = 2
# var b = "textvar"
var sprite
var collider
export var bridge1 = false

func _ready():
	sprite = get_node("Sprite")
	collider = get_node("CollisionShape2D")
	sprite.set_frame(10)
	if(bridge1 and game.bridge1):
		queue_free()
	if(game.bridge and !bridge1):
		queue_free()
