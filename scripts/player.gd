
extends KinematicBody2D

# Member variables\\
var direction = "down"
var stop = false
var anim 
var action_timer
var select_timer 
var walk_timer
var sample_player
var can_act = true
var can_select = true
var can_play_walk_sound = true
var item = "axe"
var item_index = 0
var action = preload("res://scenes/action.tscn")
var prev_direction
var crosshairs
var scale = Vector2(1,1)
var motion = Vector2(0,0)
const MOTION_SPEED = 100 # Pixels/second

func _ready():
	anim = get_node("AnimationPlayer")
	crosshairs = get_node("Position2D")
	action_timer = get_node("action_timer")
	sample_player = get_node("SamplePlayer2D")
	action_timer.connect("timeout", self, "_on_action_timer_timeout")
	walk_timer = get_node("walk_timer")
	walk_timer.connect("timeout", self, "_on_walk_timer_timeout")
	select_timer = get_node("select_timer")
	select_timer.connect("timeout", self, "_on_select_timer_timeout")
	set_fixed_process(true)

func _on_walk_timer_timeout():
	can_play_walk_sound = true

func _on_select_timer_timeout():
	can_select = true
	
func _on_action_timer_timeout():
	can_act = true
	
func set_location():
	var pos = Vector2()
		
	if(game.justins):
		pos = game.current_scene.get_node("spawn_points").get_node("justins").get_pos()
	elif(game.princess):
		pos = game.current_scene.get_node("spawn_points").get_node("princess").get_pos()
	else:
		pos = game.current_scene.get_node("spawn_points").get_node("home").get_pos()
	set_pos(pos)
	
func _fixed_process(delta):
	prev_direction = direction
	motion = Vector2(0,0)
	var is_walking = true
	if(can_act):
		stop = false
		if (Input.is_action_pressed("move_up")):
			motion += Vector2(0, -1)
			direction = "up"
		elif (Input.is_action_pressed("move_down")):
			motion += Vector2(0, 1)
			direction = "down"
		elif (Input.is_action_pressed("move_left")):
			motion += Vector2(-1, 0)
			scale.x = -1
			direction = "left"
		elif (Input.is_action_pressed("move_right")):
			motion += Vector2(1, 0)
			scale.x = 1
			direction = "right"
		else:
			is_walking = false
		
		if(is_walking and can_play_walk_sound):
			sample_player.play("walk")
			can_play_walk_sound = false
			walk_timer.start()
	
		if (Input.is_action_pressed("action")):
			do_action()
			
		if (Input.is_action_pressed("select") and can_select):
			handle_items()
	
	if(motion == Vector2(0,0)):
		stop = true
		
	do_animations()
	
	set_scale(scale)
	
	motion = motion.normalized()*MOTION_SPEED*delta
	motion = move(motion)
	
	# Make character slide nicely through the world
	var slide_attempts = 4
	while(is_colliding() and slide_attempts > 0):
		motion = get_collision_normal().slide(motion)
		motion = move(motion)
		slide_attempts -= 1

func set_crosshair():
	var pos = Vector2(1,1)
	if(direction == "up"):
		pos = Vector2(0, -10)
	elif(direction == "down"):
		pos = Vector2(0, 10)
	return pos
	
func handle_items():
	can_select = false
	select_timer.start()
	item_index += 1
	if ( item_index > 2 ):
		item_index = 0
	var select_box = game.HUD.get_node("select_box")
	var box_pos
	if( item_index == 0):
		item = "axe"
		box_pos = game.HUD.get_node("axe").get_pos()
	elif ( item_index == 1):
		item = "spade"
		box_pos = game.HUD.get_node("spade").get_pos()
	elif(item_index == 2):
		item = "pole"
		box_pos = game.HUD.get_node("pole").get_pos()
	select_box.set_pos(box_pos)

func do_animations():
	if(direction == "up"):
		if(stop):
			anim.play("up")
		else:
			if(!anim.is_playing() or prev_direction != direction):
				anim.play("walk_up")
	if(direction == "down"):
		if(stop):
			anim.play("down")
		else:
			if(!anim.is_playing() or prev_direction != direction):
				anim.play("walk_down")
	if(direction == "left" or direction == "right"):
		if(stop):
			anim.play("turn")
		else:
			if(!anim.is_playing() or prev_direction != direction):
				anim.play("walk")
	
func do_action():
	var pos = set_crosshair()
	var fx = action.instance()
	crosshairs.add_child(fx)
	fx.set_pos(pos)
	fx.play_effect(item)
	can_act = false
	action_timer.start()
