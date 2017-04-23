extends StaticBody2D

# class member variables go here, for example:
# var a = 2
# var b = "textvar"
var area
var music_label
var exit_label
var menu
var menu_done = false
var menu_index = 0

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
	if(menu_done):
		set_process(false)
	else:
		if(Input.is_action_pressed("move_up")):
			menu_index -= 1
		if (Input.is_action_pressed("move_down")):
			menu_index += 1
		if (menu_index < 0):
			menu_index = 0
		elif(menu_index > 2):
			menu_index = 0
		
		if(menu_index == 0 and Input.is_action_pressed("action")):
			manager_scene.get_node("StreamPlayer").play()
			menu_done = true
	
