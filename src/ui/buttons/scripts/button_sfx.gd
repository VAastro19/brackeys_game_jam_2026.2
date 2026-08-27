# button_sfx.gd
extends AudioStreamPlayer

@onready var button: BaseButton = get_parent()

@onready var hover_sound: AudioStream = preload("uid://bt0t1anxylvyp")
@onready var click_sound: AudioStream = preload("uid://1jog5p4gl1uq")

func _ready() -> void:
	button.mouse_entered.connect(_play_hover_sound)
	button.pressed.connect(_play_click_sound)

func _play_hover_sound() -> void:
	_play_audio(hover_sound)

func _play_click_sound() -> void:
	_play_audio(click_sound)

func _play_audio(audio: AudioStream) -> void:
	stream = audio
	play()
	
