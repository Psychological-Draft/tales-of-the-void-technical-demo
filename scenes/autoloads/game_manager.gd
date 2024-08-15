extends Node2D

@export var current_room:Room
@export var player = Player.new()
#please maintain id:quanity format 
@export var inventory ={}
#I would rather this to be on the dialogue manager, but this is like 60x smaller
#Here are the variables for the dialogues
var stand_downs_selected = 0
@export var introduction_end = false
@export var introduction_cont_end = false
@export var day:int = 1
@export var time_left:int = 1439
#a check we can change from dialogue if we want, to help signal a game over
var game_over
signal update_stats(name,status)

func _ready():
	update_stats.emit(player.user,player.statuscurrent)

func add_to_inventory(id:int):
	if inventory.has(id):
		inventory[id] = inventory[id] + 1
	else:
		inventory[id] = 1
	print(inventory)
func remove_from_inventory(id:int):
	if(inventory.has(id)):
		if inventory[id] > 0:
			inventory[id] = inventory[id]- 1
		else:
			inventory[id] = 0
	else:
		push_error("nope, this id does not exist my guy :(")
func get_current_item_amount(id:int) -> int:
	if(inventory.has(id)):
		return inventory[id]
	else:
		return 0
func spawnsome(_scene,_parent) -> void:
	var parent = get_tree().find_node(_parent)
	var scene =  load(_scene)
	parent.add_child(scene)

func set_music_value(value: float):
	Settings._on_music_value_changed(value)

func set_sound_volume(value: float):
	Settings._on_sound_value_changed(value)
func find_room():
	return get_tree().get_first_node_in_group("Room")
