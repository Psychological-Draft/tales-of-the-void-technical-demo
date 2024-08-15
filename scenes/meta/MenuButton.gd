extends TextureButton
@export var action = ""
signal coord(float)


#Send this scene's position to the arrow scene
func _on_mouse_entered():
	coord.emit(position.y)

#A way to differentiate actions to do depending on a string
func _on_pressed():
	print(action)
