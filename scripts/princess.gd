extends "justin.gd"

func set_speech():
	speech = ["I love to stand here and look at the water, its beautiful.",
			  "You seem like a strong fellow. What do you think of our neighbor?",
			  "Its good to see you. I like it when you stop by.",
			  "I dream of the day someone brings me a diamond."]
			
func _on_justin_body_enter(body):
	if(body.get_name() == "player"):
		if(game.diamond):
			game.diamond = false
			game.update_HUD()
			var messege = "You brought me a diamond! Its a dream come true! Let's get married."
			dialogue_box = game.HUD.get_node("dialogue_box")
			dialogue_box.get_node("Label").set_text(messege)
			var sample_player = get_node("SamplePlayer2D")
			sample_player.play("princess")
		else:
			var r = rand_range(0, speech.size())
			dialogue_box = game.HUD.get_node("dialogue_box")
			dialogue_box.get_node("Label").set_text(speech[r])
		dialogue_box.show()
		timer.start()
