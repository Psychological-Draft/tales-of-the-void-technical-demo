extends TextureRect


# Called when the node enters the scene tree for the first time.
func _ready():
	#get and connect the buttons with the _move_arrow function
	var butts = get_tree().get_nodes_in_group("MenuButton")
	for butt in butts:
		butt.coord.connect(_move_arrow)

#move the arrow to match the position of the selected button
func _move_arrow(ycoord):
	position.y = ycoord - 16

