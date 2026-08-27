# player_audio.gd
extends AudioStreamPlayer

func _ready() -> void:
	EventBus.UIError.connect(_play_ui_error_sfx)

func _play_ui_error_sfx() -> void:
	var ui_error_sfx: AudioStream = load("uid://wk7ohdw1b62q")
	_play_audio(ui_error_sfx)

func _play_audio(audio: AudioStream) -> void:
	stream = audio
	play()
