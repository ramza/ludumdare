extends Node2D

# class member variables go here, for example:
# var a = 2
# var b = "textvar"
var sample_player
var timer
var game_start = false

func _ready():
	timer = get_node("Timer")
	timer.connect("timeout", self, "_on_timer_timeout")
	sample_player = get_node("SamplePlayer2D")
	# Called every time the node is added to the scene.
	# Initialization here
	set_process(true)
	
func _on_timer_timeout():
	game.goto_scene("res://scenes/world.tscn")
	
func _process(delta):
	if ( Input.is_action_pressed("ui_accept") and !game_start):
		game_start = true
		timer.start()
		sample_player.play("start")
