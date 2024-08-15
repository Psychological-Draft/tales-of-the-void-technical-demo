extends Control

signal toggle_map
signal scan_room
signal shift_dim


func _on_button_shift_dimensions_pressed():
	shift_dim.emit()


func _on_button_scan_pressed():
	scan_room.emit()


func _on_button_map_pressed():
	toggle_map.emit()
	

#THIS IS DEBUG ONLY, DON'T FORGET IT YOU DUMBASS
func _unhandled_input(event):
	if event is InputEventKey:
		if event.pressed and event.keycode == KEY_X:
			push_warning("You forgot to change the debug exploration toggle, dumbass!")
			visible = !visible
