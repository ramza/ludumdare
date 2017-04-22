extends Node

var tilemap
var timer

func _ready():
	tilemap = get_tree().get_root().get_child(1).get_node("tilemap")
	var timer = get_node("Timer")
	timer.connect("timeeout", self, "_on_timer_timeout")
	fish_handler()
	
func _on_timer_timeout():
	fish_handler()

func fish_handler():
	var all = tilemap.get_used_cells()
	var cellsOfIndex = []
	for tile in all:
		if (tilemap.get_cell(tile.x, tile.y) == 2):
			cellsOfIndex.append(tile)
	print(cellsOfIndex.size())
