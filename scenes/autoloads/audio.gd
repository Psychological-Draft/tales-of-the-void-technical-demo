extends Node


func play_music(path: String) -> void:
	if $Music.stream and $Music.stream.resource_path == path:
		return
	$Music.stream = load(path)
	$Music.play()


func stop_music_volume() -> void:
	$Music.stream = null


func play_sound(path: String,_pitch = 1.0) -> void:
	if path == "":
		pass
	else:
		var p := AudioStreamPlayer.new()
		p.stream = load(path)
		p.bus = "Sound"
		p.autoplay = true
		p.pitch_scale = _pitch
		add_child(p)
		p.finished.connect(p.queue_free)
