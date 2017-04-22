extends StaticBody2D

# class member variables go here, for example:
# var a = 2
# var b = "textvar"
var anim 
var health = 3
var chips = preload("res://scenes/effects.tscn")

func _ready():
	anim = get_node("AnimationPlayer")
	anim.play("still")
	# Called every time the node is added to the scene.
	# Initialization here
	pass
	
func hit(var damage):
	health -= damage
	if(health <= 0):
		queue_free()
		game.add_harvested_rocks(1)
	else:
		anim.play("shake")
		var fx = chips.instance()
		add_child(fx)
	