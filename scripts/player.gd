
extends KinematicBody2D

# Member variables\\

var direction = "down"
var stop = false
var anim 
var action_timer
var can_act = true
var item = "axe"
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
	action_timer.connect("timeout", self, "_on_action_timer_timeout")
	set_fixed_process(true)

func _on_action_timer_timeout():
	can_act = true

func _fixed_process(delta):
	prev_direction = direction
	motion = Vector2(0,0)
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
		
		if (Input.is_action_pressed("action")):
			do_action()
	
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
	if (item == "axe"):
		var fx = action.instance()
		crosshairs.add_child(fx)
		fx.set_pos(pos)
		fx.play_effect(item)
		can_act = false
		action_timer.start()