extends Control

@onready var mini_map = $"Map Background/MapUI/MiniMap"

func find_room_by_id(id):
	var rooms = mini_map.get_mini_rooms()
	for room in rooms:
		if room.id == id:
			return room
	push_error("something happened, and the id you were searching for wasn't found on the minimap")
	return null

func find_room_by_location(pos:Vector2):
	var rooms = mini_map.get_mini_rooms()
	for room in rooms:
		if room.room_location == pos:
			return room
	push_error("something happened, and the location you were searching for wasn't found on the minimap")
	return null
