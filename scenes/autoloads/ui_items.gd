extends Control

@onready var item_name = $"VBoxContainer/Item Name"
@onready var item_description = $"VBoxContainer/Item description"
@onready var item_remaining = $"VBoxContainer/Item remaining"
@onready var items_container = $ScrollContainer/ItemsContainer
@export var item_listed :PackedScene = load("res://scenes/UI/item_listed.tscn")
# Called when the node enters the scene tree for the first time.



func _on_item_selected(i,d,r):
	item_name.text = i
	item_description.text = d
	item_remaining.text = r
func _on_items_opened():
	#create one item listed per item on your inventory
	var list_item
	for item in UI.items:
		list_item = item_listed.instantiate()
		list_item.item_name = item.name
		list_item.item_desc = item.description
		list_item.item_rem = "remaining: 1" 
		#connect each item listed to _on_item_selected
		items_container.add_child(list_item)
		list_item.selected.connect(_on_item_selected)
		
func add_item_to_list(item:Item):
	var list_item = item_listed.instantiate()
	list_item.name = item.name
	list_item.item_name = item.name
	list_item.item_desc = item.description
	list_item.item_rem = "remaining: " + str(GameManager.get_current_item_amount(item.id))
#connect each item listed to _on_item_selected
	list_item.selected.connect(_on_item_selected)
	items_container.add_child(list_item)

func update_item(item:Item):
	var list_item = items_container.get_node(item.name)
	list_item.item_name = item.name
	list_item.item_desc = item.description
	list_item.item_rem = "remaining: " + str(GameManager.get_current_item_amount(item.id))



#THIS IS DEBUG ONLY, DON'T FORGET IT YOU DUMBASS
func _unhandled_input(event):
	if event is InputEventKey:
		if event.pressed and event.keycode == KEY_Z:
			push_warning("You forgot to change the debug inventory toggle, dumbass!")
			visible = !visible
