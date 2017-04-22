extends Node

# class member variables go here, for example:
# var a = 2
# var b = "textvar"
var trees = 0
var rocks = 0
var HUD

func add_harvested_trees(var value):
	trees += value
	HUD.get_node("tree").get_node("Label").set_text(str(trees))

func add_harvested_rocks(var value):
	rocks+= value
	HUD.get_node("rocks").get_node("Label").set_text(str(rocks))
	
func _ready():
	HUD = get_tree().get_root().get_child(1).get_node("HUD")
	# Called every time the node is added to the scene.
	# Initialization here
	pass
