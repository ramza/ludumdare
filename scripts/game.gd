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
var manager_scene
var can_spawn = true
var resources = []

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
	current_scene = get_tree().get_root().get_child(2)
	HUD = current_scene.get_node("HUD")
	player = current_scene.get_node("player")
	
	# Called every time the node is added to the scene.
	# Initialization here
	pass
	
func load_essentials():
	player = current_scene.get_node("player")
	HUD = current_scene.get_node("HUD")
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

func add_resource(var resource):
	call_deferred("_deferred_add_resource", resource)
	
func _deferred_add_resource(var resource):
	game.current_scene.add_child(resource)
		
func clear_resources():
	for i in range(resources.size()-1, -1, -1):
		print("anything?")
		if (resources[i] != null):
			resources[i].queue_free()
			resources.remove(i)
	resources.clear()