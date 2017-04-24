extends KinematicBody2D

var speech = ["if you see this someting is wrong."]
var area
var dialogue
var dialogue_box
var timer

func _ready():
	area = get_node("Area2D")
	timer = get_node("Timer")
	area.connect("body_enter", self, "_on_justin_body_enter")
	timer.connect("timeout", self, "_on_timer_timeout")
	set_speech()
	
func _on_timer_timeout():
	game.player.can_act = true
	dialogue_box.hide()
	timer.stop()
	
func set_speech():
	speech = ["It would be nice if certain people could learn to stay on their side of the island.",
		      "heh. I'm much better looking than you are.",
			  "The princess likes me more than you, I'm sure of it. She gave me a fish.",
			  "I don't really like your house.",
			  "You want to play some topnosis? Never mind, I forgot how bad you are at it.",
			  "You know that big diamond to the south? I'm going to get it."]

func _on_justin_body_enter(body):
	if(body.get_name() == "player"):
		var r = rand_range(0, speech.size())
		dialogue_box = game.HUD.get_node("dialogue_box")
		dialogue_box.get_node("Label").set_text(speech[r])
		dialogue_box.show()
		timer.start()