extends Area2D

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

func _ready():
	connect("body_enter", self, "_on_portal_body_enter")
	# Called every time the node is added to the scene.
	# Initialization here
	pass

func _on_portal_body_enter(body):
	if(body.get_name() == "player"):
		game.goto_scene("res://scenes/world.tscn")
