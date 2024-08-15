extends TextureRect

@export var room_name:String
@export var room_description:String
@export var id:int
@export var room_location:Vector2
@export var path:String
@export var accesible_by:Array[Vector2]

signal clicked()



func _on_texture_button_pressed():
	clicked.emit(room_name,room_description,path,id)
func get_accesibles():
	return accesible_by
