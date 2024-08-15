extends Control
@onready var label_name = $VBoxContainer/LabelName
@onready var label_status = $VBoxContainer/LabelStatus


# Called when the node enters the scene tree for the first time.
func _ready():
	GameManager.update_stats.connect(update_labels)



func update_labels(user,status):
	label_name.text = user
	label_status.text = GameManager.player.return_status(GameManager.player.status.flunkered)
	
	
