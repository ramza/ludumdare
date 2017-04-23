extends StaticBody2D

# class member variables go here, for example:
# var a = 2
# var b = "textvar"
var area
var music_label
var exit_label
var menu

func _ready():
	area = get_node("Area2D")
	area.connect("body_enter", self, "_on_computer_body_enter")
	music_label = get_node("music_label")
	exit_label = get_node("exit_label")
	menu = game.current_scene.get_node("menu")
	menu.get_node("music_label").hide()
	menu.get_node("exit_label").hide()
	# Called every time the node is added to the scene.
	# Initialization here
	
func _on_computer_body_enter(body):
	if ( body.get_name() == "player"):
		menu.get_node("music_label").show()
		menu.get_node("exit_label").show()
		set_process(true)

func _process(delta):
	pass
