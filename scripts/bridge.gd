extends StaticBody2D

# class member variables go here, for example:
# var a = 2
# var b = "textvar"
var sprite
var collider

func _ready():
	sprite = get_node("Sprite")
	collider = get_node("CollisionShape2D")
	
	if (game.bridge):
		queue_free()
	elif(!game.bridge):
		sprite.set_frame(10)
		
	# Called every time the node is added to the scene.
	# Initialization here
	pass
