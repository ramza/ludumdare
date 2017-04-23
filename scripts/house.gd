extends Sprite

# class member variables go here, for example:
# var a = 2
# var b = "textvar"
var area

func _ready():
	area = get_node("Area2D")
	area.connect("body_enter", self, "_on_house_body_enter")
	# Called every time the node is added to the scene.
	# Initialization here
	
func _on_house_body_enter(body):
	if (body.get_name() == "player"):
		game.goto_scene("res://scenes/house.tscn")
