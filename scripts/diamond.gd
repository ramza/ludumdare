extends StaticBody2D

# class member variables go here, for example:
# var a = 2
# var b = "textvar"
var anim 
var health = 3
var chips = preload("res://scenes/effects.tscn")
var timer 

func _ready():
	anim = get_node("AnimationPlayer")
	timer = get_node("Timer")
	timer.connect("timeout", self, "_on_timer_timeout")
	# Called every time the node is added to the scene.
	# Initialization here
	pass
	
func _on_timer_timeout():
	queue_free()
	
func hit(var damage):
	health -= damage
	if(health <= 0):
		queue_free()
		game.diamond = true
	else:
		anim.play("shake")
		var fx = chips.instance()
		add_child(fx)
	