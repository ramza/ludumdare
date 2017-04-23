extends KinematicBody2D

# class member variables go here, for example:
# var a = 2
# var b = "textvar"
var area
var dialogue
var dialogue_box
var timer

func _ready():
	area = get_node("Area2D")
	timer = get_node("Timer")
	dialogue_box = game.HUD.get_node("dialogue_box")
	area.connect("body_enter", self, "_on_justin_body_enter")
	timer.connect("timeout", self, "_on_timer_timeout")
	
func _on_timer_timeout():
	game.player.can_act = true
	dialogue_box.hide()

func _on_justin_body_enter(body):
	if(body.get_name() == "player"):
		dialogue_box.show()
		game.player.can_act = false
		timer.start()

