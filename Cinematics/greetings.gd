extends Node2D

var canvas
var volume
func _entity_found()-> void:
	volume = Settings.music_value 
	UI.toggle_settings(false)
#	print(volume)
	#GameManager.set_music_value(volume/5)
	
	canvas = DialogueManager.show_dialogue_balloon(load("res://dialogues/greetings.dialogue"),"entity_found")
	var balloon = canvas.get_node("Balloon")
	canvas.isUnskippable = true
	balloon.mouse_filter=2

func _greetings() -> void:
	feed_next_line()
	Audio.play_sound("res://Audio/Audio-Klaus-Talking.wav")
	canvas = DialogueManager.show_dialogue_balloon(load("res://dialogues/greetings.dialogue"),"greetings")	
	canvas.isUnskippable = true
	#Make it so that the dialogue is unskippable
	var balloon = canvas.get_node("Balloon")
	balloon.mouse_filter=2
	
func _lights_on() -> void:
	Audio.play_sound("res://Audio/Audio-Klaus-ClosingIn.wav")
	
func _close_in() -> void:
	Audio.play_sound("res://Audio/Audio-Klaus-LightClose.wav")
	
func _leaving() -> void:
	feed_next_line()
	Audio.play_sound("res://Audio/Audio-Klaus-Leaving.wav")
	#GameManager.set_music_value(volume)
	
	UI.toggle_settings(true)
	
func feed_next_line() -> void:
	#skips to the next line of dialogue
	canvas.next(canvas.dialogue_line.next_id)
	pass
