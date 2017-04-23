extends Node

# class member variables go here, for example:
# var a = 2
# var b = "textvar"
var trees = 0
var rocks = 0
var fish = 0
var HUD
var player
var current_scene

func update_HUD():
	HUD.get_node("tree").get_node("Label").set_text(str(trees))
	HUD.get_node("rocks").get_node("Label").set_text(str(rocks))
	HUD.get_node("fish").get_node("Label").set_text(str(fish))
	
func add_harvested_trees(var value):
	trees += value
	HUD.get_node("tree").get_node("Label").set_text(str(trees))

func add_harvested_rocks(var value):
	rocks+= value
	HUD.get_node("rocks").get_node("Label").set_text(str(rocks))
	
func add_harvested_fish(var value):
	fish += value
	HUD.get_node("fish").get_node("Label").set_text(str(fish))
	
func _ready():
	HUD = get_tree().get_root().get_child(1).get_node("HUD")
	player = get_tree().get_root().get_child(1).get_node("player")
	current_scene = get_tree().get_root().get_child(1)
	# Called every time the node is added to the scene.
	# Initialization here
	pass
	
func load_essentials():
	player = get_tree().get_root().get_child(1).get_node("player")
	HUD = get_tree().get_root().get_child(1).get_node("HUD")
	update_HUD()
func goto_scene(path):

    call_deferred("_deferred_goto_scene",path)

func _deferred_goto_scene(path):
    # Immediately free the current scene,
    # there is no risk here.
    current_scene.free()

    # Load new scene
    var s = ResourceLoader.load(path)

    # Instance the new scene
    current_scene = s.instance()
    # Add it to the active scene, as child of root
    get_tree().get_root().add_child(current_scene)

    # optional, to make it compatible with the SceneTree.change_scene() API
    get_tree().set_current_scene( current_scene )
    load_essentials()
