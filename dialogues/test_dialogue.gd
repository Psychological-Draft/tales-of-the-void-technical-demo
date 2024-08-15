extends BaseDialogueTestScene

func _ready() -> void:
	var baloon = load("res://dialogues/balloon.tscn").instantiate()
	get_tree().current_scene.add_child(baloon)
	baloon.start(resource,title)
