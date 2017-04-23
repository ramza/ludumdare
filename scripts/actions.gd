extends Node2D

# class member variables go here, for example:
# var a = 2
# var b = "textvar"
var anim
var sample_player
var timer
var sprite
var area
var type

var weapon_timer

func _ready():
	
	anim = get_node("AnimationPlayer")
	sample_player = get_node("SamplePlayer2D")
	timer = get_node("Timer")
	sprite = get_node("Sprite")
	area = get_node("Area2D")
	area.connect("area_enter", self, "_on_effects_area_enter")
	timer.connect("timeout", self, "_on_effects_timer_timeout")
	
#takes weapon name string as a type and plays the correct effect
func play_effect(var _type):
	type = _type
	timer.start()
	anim.play(type)
	if(type != "pole"):
		sample_player.play(type)
	
func _on_effects_timer_timeout():
	queue_free()
	
func _on_effects_area_enter(area):
	if (type == "axe" and area.get_parent().is_in_group("trees")):
		area.get_parent().hit(1)
	elif (type == "spade" and area.get_parent().is_in_group("rocks")):
		area.get_parent().hit(1)
	elif (type == "pole" and area.get_parent().is_in_group("fish")):
		area.get_parent().hit(1)
		sample_player.play(type)
