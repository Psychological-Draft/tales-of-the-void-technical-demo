extends CanvasLayer


const TOGGLE_TIME := 0.2

@export var ItemIconScene: PackedScene
signal dialogue_finished
signal exp_toggle_map
signal exp_shift_dim
signal exp_scan_room
var inventory_visible := true

var items: Array[Item] = []
var selected_item := -1

@onready var control := $Control
@onready var right := $Control/Right
@onready var toggle := $Control/Right/Toggle
@onready var inventory_vbox := $Control/Right/Inventory/Scroll/VBox
@onready var settings := $Control/TopLeft/Settings
@onready var save_load := $Control/TopLeft/SaveLoad
@onready var ui_exploration = $Control/BaseUI/UIExploration
@onready var ui_items = $Control/BaseUI/UIItems
@onready var map = $Control/Map
@onready var player_pointer = $Control/Map/"Map Background"/MapUI/MiniMap/PlayerPointer
@onready var mini_map = $Control/Map/"Map Background"/MapUI/MiniMap


func _ready():
	DialogueManager.dialogue_ended.connect(_on_dialogue_ended)
	ui_exploration.toggle_map.connect(toggle_map)
	ui_exploration.shift_dim.connect(shift_dim)
	ui_exploration.scan_room.connect(scan_room)


func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("inventory"):
		_on_toggle_pressed()

func toggle_settings(hidden: bool):
	settings.visible = hidden
	save_load.visible = hidden


func _on_toggle_pressed() -> void:
	inventory_visible = not inventory_visible
	var tween := get_tree().create_tween()
	if inventory_visible:
		tween.tween_property(right, "position:x", control.size.x - right.size.x, TOGGLE_TIME)
		toggle.text = ">"
	else:
		tween.tween_property(right, "position:x", control.size.x - toggle.size.x, TOGGLE_TIME)
		toggle.text = "<"


func add_item(item: Item) -> void:
	
	if !GameManager.inventory.has(item.id):
		items.append(item)
		var item_icon := ItemIconScene.instantiate()
		inventory_vbox.add_child(item_icon)
		item_icon.set_data(item)
		item_icon.item_selected.connect(on_item_selected)
		item_icon.combine_requested.connect(on_item_combine_requested)
		GameManager.add_to_inventory(item.id)
		ui_items.add_item_to_list(item)
	else:
		GameManager.add_to_inventory(item.id)
		ui_items.update_item(item)


func show_dialogue(d: String,nam: String = "greetings") -> void:
		DialogueManager.show_dialogue_balloon(load("res://dialogues/%s.dialogue" % nam),d)

#Connect both assets
func _on_dialogue_ended(_resource) ->void:
	dialogue_finished.emit()

func on_item_selected(index: int) -> void:
	selected_item = index


# Must be called deferred
func remove_item(target_id: int) -> void:
	for i in items.size():
		if items[i].id == target_id:
			items.remove_at(i)
			inventory_vbox.get_child(i).free()
			if i == selected_item:
				selected_item = -1
			return
	push_warning("Couldn't find item with id %s in inventory to remove!" % target_id)


func deselect_item() -> void:
	if selected_item == -1:
		return
	inventory_vbox.get_child(selected_item).toggle_selected(false)
	selected_item = -1


func toggle_ui(enable: bool) -> void:
	control.visible = enable


func _on_save_load_pressed() -> void:
	SaveLoad.show_save_load(true)


# Will be called deferred, that's why I'm using free instead of queue_free
func clear() -> void:
	for child in inventory_vbox.get_children():
		child.free()
	items = []
	

func select_item(index: int) -> void:
	if index !=-1:
		inventory_vbox.get_child(index).toggle_selected(true)
	#push_error("You have something to fix here :( it breaks whenever you click load, out of index or something)")
	pass


func _on_settings_pressed() -> void:
	Settings.show_settings(true)


func on_item_combine_requested(index: int) -> void:
	if selected_item == -1:
		return
	if not get_tree().current_scene is Room:
		return
	var actions = items[selected_item].get_combination_from_id(items[index].id, true).duplicate()
	if actions:
		get_tree().current_scene.current_actions = actions
	else:
		
		get_tree().current_scene.current_actions = GameState.FALLBACK_COMBINATION.actions.duplicate()
	get_tree().current_scene.call_deferred("advance_actions")

func spawn_something(_scene,_parent) -> void:
	var parent = get_node(_parent)
	var scene =  load(_scene).instantiate()
	
	parent.add_child(scene)
func toggle_map():
	exp_toggle_map.emit()
	map.visible = !map.visible 
func scan_room():
	exp_scan_room.emit()
func shift_dim():
	exp_shift_dim.emit()
func get_player_pointer():
	return player_pointer
func hide_all():
	visible = false

func get_mini_room_position_by_id(id):
	var room = map.find_room_by_id(id)
	if room:
		return room.position
	return null
