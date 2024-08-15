extends CharacterBody2D
var speed = 300
var accel = 7
var tracking = true
@onready var nav:NavigationAgent2D = $NavigationAgent2D
@onready var current_room = $"../Minimap_Room"


func _ready():
	var rooms = get_tree().get_nodes_in_group("Minimap Room")

	for room in rooms:
		room.clicked.connect(_on_room_pressed)

func _physics_process(delta):
	if tracking:
		var direction = Vector3()
		#nav.target_position = get_global_mouse_position()
		direction = nav.get_next_path_position() - global_position
		direction = direction.normalized()
		velocity = velocity.lerp(direction * speed, accel * delta)
		move_and_slide()


func _on_room_pressed(pos:Vector2):
	nav.target_position = pos
	tracking = true



func _on_navigation_agent_2d_navigation_finished():
	tracking = false
	print("arrived")
