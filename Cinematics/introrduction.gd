extends Node2D

var canvas
var volume
var ended = false
@onready var background = $Background

# Called when the node enters the scene tree for the first time.
func _ready():
	if !GameManager.introduction_end:
		volume = Settings.music_value 
		#UI.toggle_settings(false)
		#print(volume)
		#GameManager.set_music_value(volume/5)
		
		canvas = DialogueManager.show_dialogue_balloon(load("res://dialogues/greetings.dialogue"),"introduction")
		if GameManager.current_room != null and !ended:
			GameManager.current_room.hide_interactables()
		#var balloon = canvas.get_node("Balloon")
		#UI.hide_all()
		#hide_background()
		#canvas.isUnskippable = false
		#balloon.mouse_filter=2


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if GameManager.introduction_end:
		GameManager.current_room.show_interactables()
		ended = true
		if !GameManager.introduction_cont_end:
			canvas = DialogueManager.show_dialogue_balloon(load("res://dialogues/greetings.dialogue"),"introduction_continuation")
		queue_free()
		

