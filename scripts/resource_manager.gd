extends Node

var tilemap
var timer
var fish = preload("res://scenes/fish.tscn")
var tree = preload("res://scenes/tree.tscn")
var rock = preload("res://scenes/rocks.tscn")

func _ready():
	tilemap = game.current_scene.get_node("tilemap")
	var timer = get_node("Timer")
	timer.connect("timeout", self, "_on_timer_timeout")
	timer.start()
	spawn_handler()
	
func _on_timer_timeout():
	spawn_handler()

func spawn_handler():
	var all = tilemap.get_used_cells()
	var trees = []
	var fishes = []
	
	for tile in all:
		if (tilemap.get_cell(tile.x, tile.y) == 3):
			if(rand_range(0, 100) < 5):
				var fishy = fish.instance()
				var pos = Vector2(tile.x * 16, tile.y*16)
				fishy.set_pos(pos)
				game.current_scene.add_child(fishy)
				fishes.append(fishy)
		if (tilemap.get_cell(tile.x, tile.y) == 7):
			if(rand_range(0, 10) < 2):
				var t = tree.instance()
				var pos = Vector2(tile.x * 16, tile.y*16)
				t.set_pos(pos)
				game.current_scene.add_child(t)
				trees.append(t)
			if(rand_range(0, 300) < 2):
				var r = rock.instance()
				var pos = Vector2(tile.x * 16, tile.y*16)
				r.set_pos(pos)
				game.current_scene.add_child(r)
		if (tilemap.get_cell(tile.x, tile.y) == 6):
			if(rand_range(0, 5000) < 2):
				var r = rock.instance()
				var pos = Vector2(tile.x * 16, tile.y*16)
				r.set_pos(pos)
				game.current_scene.add_child(r)
