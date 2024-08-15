extends TextureRect


@onready var room_name = $Room_Name
@onready var room_desc = $Room_Desc
@onready var room_distance = $Room_Distance
@onready var teleport_button = $Teleport_Button

@onready var clock = $Clock
@onready var map = $"../.."
@onready var mini_map = $MiniMap
var count
var current_path
var time_to_travel
# Called when the node enters the scene tree for the first time.
func _ready():
	clock.text = "Day %s  "% GameManager.day+"-  %s "  % (GameManager.time_left / 60) +":%s  Before Sunset" % (GameManager.time_left % 60)

#called when player clicks a node on the minimap, tasked to
#find the closest navigable path to it, and return how much distance it covered
func find_path(pos:Vector2,goal:Vector2 ):
	var distance_travelled = 0
	var found = false
	var patt  = [pos]
	var path_forward = attempt_path(pos,goal,patt,found,false)
	var temp_patt = [pos]
	found = false
	var path_backwards = attempt_path(pos,goal,temp_patt,found,true)
	if patt.size() <= temp_patt.size():
		distance_travelled = path_forward.size() -1
	else:
		distance_travelled = path_backwards.size() -1
	return distance_travelled
	
func attempt_path(pos, goal, patt, found,reversed):
	var new_pos = pos
	count = 0
	while !found:
		var pos_room = map.find_room_by_location(new_pos)
		var pos_accesibles = pos_room.get_accesibles()
		new_pos = get_closest_vector(goal,pos_accesibles,patt, reversed)
		count +=1
		if patt[patt.size()-1] == goal:
			found = true
		if count > 100:
			push_error("overflowed")
			break
	return patt
func get_closest_vector(goal:Vector2,accesibles:Array,patt:Array,reversed:bool):
	var acc_room
	var vec
	var in_range
#cycles through the accesibles provided, returning the smallest vector 
	if reversed:
		acc_room = map.find_room_by_location(accesibles[accesibles.size()-1])
		vec = goal - accesibles[accesibles.size()-1]
		in_range = range(accesibles.size() -1,-1,-1)
	else:
		acc_room = map.find_room_by_location(accesibles[0])
		vec = goal - accesibles[0]
		in_range = range(accesibles.size())
	var min_mod = (vec.x * vec.x) + (vec.y * vec.y)
	for i in in_range:
		var accesible = accesibles[i]
		vec = goal - accesible
		var module = (vec.x * vec.x) + (vec.y * vec.y)
		if module <= min_mod and patt.find(accesible) == -1:
			if patt.find(accesible) == -1:
				min_mod = module
				acc_room = map.find_room_by_location(accesible)
			else:
				push_error("backtracking insued")
	if acc_room != null:
		var acc_location = acc_room.room_location
		if patt.find(acc_room.room_location) == -1:
			acc_location = acc_room.room_location
			patt.append(acc_location)
		else:
			for acc in accesibles:
				if patt.find(acc) == -1:
					acc_room = map.find_room_by_location(acc)
					acc_location = acc_room.room_location
					patt.append(acc_location)
					break
		return acc_location
	else:
		push_error("the loop  isn't doing  its job",patt)
		if reversed:
			return accesibles[accesibles.size()-1]
		else:
			return accesibles[0]
func _on_mini_map_request_minimap_info(room,desc,path,id):
	room_name.text = room
	room_desc.text = desc
	var origin = GameManager.current_room.minimaplocation
	var end = map.find_room_by_id(id).room_location
	var distance = find_path(origin,end)
	room_distance.text = "This will take "+ str(distance*15) + " minutes. Proceed?"
	teleport_button.show()
	current_path = path
	time_to_travel = distance * 15


func _on_teleport_button_pressed():
	teleport_button.hide()
	get_tree().change_scene_to_file(current_path)
	GameManager.time_left -= time_to_travel
	clock.text = "Day %s  "% GameManager.day+"-  %s "  % (GameManager.time_left / 60) +":%s  Before Sunset" % (GameManager.time_left % 60)
