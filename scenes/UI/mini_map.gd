extends TextureRect
@onready var player_pointer = $PlayerPointer
@onready var map = $"../../.."
@onready var map_ui = $".."

signal request_minimap_info(room)
# Called when the node enters the scene tree for the first time.
func _ready():
	var mini_rooms = get_mini_rooms()
	for mini_room in mini_rooms:
		mini_room.clicked.connect(_on_mini_room_clicked)


func _on_mini_room_clicked(room_name,desc,path,id):
	request_minimap_info.emit(room_name,desc,path,id)
	if path:
		#map_ui.find_path(GameManager.current_room.minimaplocation,map.find_room_by_id(id).room_location)
		pass
	else:
		push_error("there's no valid path on the minimap thingy")
func get_mini_rooms():
	return  get_tree().get_nodes_in_group("Minimap Room")
