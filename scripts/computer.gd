extends StaticBody2D

# class member variables go here, for example:
# var a = 2
# var b = "textvar"
var area
var music_label
var exit_label
var bridge_label
var menu_select_box
var sample_player
var menu
var menu_done = false
var menu_index = 0
var timer
var can_input = true
export var justins_computer = false
export var princess_computer = false

func _ready():
	game.can_spawn = false
	area = get_node("Area2D")
	area.connect("body_enter", self, "_on_computer_body_enter")
	menu = game.current_scene.get_node("menu")
	
	sample_player = get_node("SamplePlayer2D")
	timer = menu.get_node("Timer")
	timer.connect("timeout", self, "_on_timer_timeout")
	music_label = menu.get_node("music_label")
	exit_label = menu.get_node("exit_label")
	bridge_label = menu.get_node("bridge_label")
	menu_select_box = menu.get_node("menu_select_box")
	menu.get_node("music_label").hide()
	menu.get_node("exit_label").hide()
	bridge_label.hide()
	menu_select_box.hide()
	# Called every time the node is added to the scene.
	# Initialization here

func set_labels_visible(var is_visible):
	if(is_visible):
		bridge_label.show()
		music_label.show()
		bridge_label.show()
		exit_label.show()
		menu_select_box.show()
	else:
		bridge_label.hide()
		music_label.hide()
		bridge_label.hide()
		exit_label.hide()
		menu_select_box.hide()


func _on_timer_timeout():
	can_input = true
	
func _on_computer_body_enter(body):
	if ( body.get_name() == "player"):
		menu.get_node("music_label").show()
		menu.get_node("exit_label").show()
		if(!game.bridge):
			bridge_label.show()
		if(!game.bridge1 and justins_computer):
			bridge_label.show()
		if(princess_computer and !game.has_super_axe):
			bridge_label.show()
		menu_done = false
		menu_select_box.show()
		game.player.can_act = false
		game.player.action_timer.stop()
		sample_player.play("computer")
		can_input = false
		timer.start()
		set_process(true)
		
func _process(delta):
	if(menu_done):
		set_process(false)
	elif(can_input):
		if(Input.is_action_pressed("move_up")):
			menu_index -= 1
			can_input = false
			timer.start()
			sample_player.play("select")
		elif (Input.is_action_pressed("move_down")):
			menu_index += 1
			can_input = false
			timer.start()
			sample_player.play("select")
			
		if (menu_index < 0):
			menu_index = 0
		elif(menu_index > 2):
			menu_index = 2
		
		var box_pos = Vector2(music_label.get_node("Sprite").get_pos().x, music_label.get_node("Sprite").get_pos().y+menu_index*32)
		menu_select_box.set_pos(box_pos)
		
		if(Input.is_action_pressed("action")):
			can_input = false
			timer.start()
			if(menu_index == 0 ): 
				if(!manager_scene.get_node("StreamPlayer").is_playing()):
					manager_scene.get_node("StreamPlayer").play()
				else:
					manager_scene.get_node("StreamPlayer").stop()
				can_input = false
			elif(menu_index == 1):
				if(!game.has_super_axe and princess_computer):
					if(game.trees >= 20 and game.rocks >= 20 and game.fish >= 20):
						game.trees -= 20
						game.rocks -= 20
						game.fish-= 20
						game.has_super_axe = true
						game.update_HUD()
						bridge_label.hide()
						sample_player.play("powerup")
					else:
						sample_player.play("wrong")
				elif(!game.bridge1 and justins_computer):
					if(game.trees >= 10 and game.rocks >= 10 and game.fish >= 10):
						game.trees -= 10
						game.rocks -= 10
						game.fish-= 10
						game.bridge1 = true
						game.update_HUD()
						bridge_label.hide()
						sample_player.play("powerup")
					else:
						sample_player.play("wrong")
				elif(!game.bridge):
					if(game.trees >= 5 and game.rocks >= 5 and game.fish >= 5):
						game.trees -=5
						game.rocks -=5
						game.fish-=5
						game.bridge = true
						game.update_HUD()
						bridge_label.hide()
						sample_player.play("powerup")
					else:
						sample_player.play("wrong")
			elif(menu_index == 2):
				menu_done = true
				game.player.can_act = true
				game.player.action_timer.start()
				set_labels_visible(false)
				set_process(false)
				sample_player.play("computer")
				menu_index = 0
	
