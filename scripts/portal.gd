extends Area2D

# class member variables go here, for example:
# var a = 2
# var b = "textvar"
var justins
var princess

func _ready():
	connect("body_enter", self, "_on_portal_body_enter")
	justins = game.current_scene.get_node("computer").justins_computer
	princess = game.current_scene.get_node("computer").princess_computer
	# Called every time the node is added to the scene.
	# Initialization here
	pass

func _on_portal_body_enter(body):
	if(body.get_name() == "player"):
		game.justins = justins
		game.princess = princess
		game.in_overworld = true
		game.goto_scene("res://scenes/world.tscn")
