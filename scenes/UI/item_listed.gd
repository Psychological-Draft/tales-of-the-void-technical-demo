extends Button

var item_name = "pepito"
var item_desc = "random description"
var item_rem = "remaining: 1"
var item:Item
signal selected(n,d,r)

# Called when the node enters the scene tree for the first time.
func _ready():
	text = item_name



func _on_mouse_entered():
	selected.emit(item_name,item_desc,item_rem)






func _on_pressed():
	print("I was pressed :=D")
