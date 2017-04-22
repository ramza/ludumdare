extends Node2D

# class member variables go here, for example:
# var a = 2
# var b = "textvar"
var anim
var timer
var sprite

func _ready():
	
	anim = get_node("AnimationPlayer")
	timer = get_node("Timer")
	sprite = get_node("Sprite")
	timer.connect("timeout", self, "_on_effects_timer_timeout")
	play_effect("chips")
#takes effects name string as a type and plays the correct effect
func play_effect(var type):
	timer.start()
	anim.play(type)
	
func _on_effects_timer_timeout():
	queue_free()
	
func _on_effects_area_enter(area):
	if (area.is_in_group("tree")):
		print("hit a tree")
