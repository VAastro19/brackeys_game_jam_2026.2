# player_audio.gd
extends AudioStreamPlayer

@export var footstep_sounds: Array[AudioStream]
@export var play_rate: float = 0.25
var last_play_time: float

func _ready() -> void:
	EventBus.UIError.connect(_play_ui_error_sfx)
	EventBus.OnPlayerDead.connect(_play_death_sfx)
	EventBus.OnPlayerMove.connect(_play_footsteps_sfx)
	EventBus.OnPlayerAttack1.connect(_play_attack_1_sfx)
	EventBus.OnPlayerAttack2.connect(_play_attack_2_sfx)
	EventBus.OnPlayerAttack3.connect(_play_attack_3_sfx)

func _play_footsteps_sfx() -> void:
	if Time.get_unix_time_from_system() - last_play_time <  play_rate:
		return
	
	last_play_time = Time.get_unix_time_from_system()
	var audio = footstep_sounds[randi() % len(footstep_sounds)]
	
	volume_db = 0
	pitch_scale = 2.0
	_play_audio(audio)

func _play_attack_1_sfx() -> void:
	var attack_1_sfx: AudioStream = load("uid://iq2dggrtulyl")
	volume_db = -12
	pitch_scale = 1.0
	_play_audio(attack_1_sfx)

func _play_attack_2_sfx() -> void:
	var attack_2_sfx: AudioStream = load("uid://b4rba2038y14t")
	volume_db = -12
	pitch_scale = 1.0
	_play_audio(attack_2_sfx)

func _play_attack_3_sfx() -> void:
	var attack_3_sfx: AudioStream = load("uid://dkx3pisxlna4")
	volume_db = -12
	pitch_scale = 1.0
	_play_audio(attack_3_sfx)

func _play_death_sfx() -> void:
	var death_sfx: AudioStream = load("uid://cxc1tkwxa48ql")
	volume_db = 0
	pitch_scale = 1.0
	_play_audio(death_sfx)

func _play_ui_error_sfx() -> void:
	var ui_error_sfx: AudioStream = load("uid://wk7ohdw1b62q")
	volume_db = -5
	pitch_scale = 1.0
	_play_audio(ui_error_sfx)

func _play_audio(audio: AudioStream) -> void:
	stream = audio
	play()
