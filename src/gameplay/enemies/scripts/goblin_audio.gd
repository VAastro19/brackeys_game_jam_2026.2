# goblin_audio.gd
extends AudioStreamPlayer

@onready var axe_hit_sfx: AudioStream = preload("uid://bcxn0aam0l4g6")
@onready var goblin_death_sfx: AudioStream = preload("uid://c7exj12slf7bh")

@export var goblin_sounds: Array[AudioStream]
@export var play_rate: float = 16
var last_play_time: float

func _ready() -> void:
	EventBus.OnGoblinWalk.connect(_play_goblin_sounds)
	EventBus.OnGoblinAttack.connect(_play_axe_hit)
	EventBus.OnGoblinDead.connect(_play_goblin_death)

func _play_goblin_sounds() -> void:
	if Time.get_unix_time_from_system() - last_play_time <  play_rate:
		return
	
	last_play_time = Time.get_unix_time_from_system()
	var audio = goblin_sounds[randi() % len(goblin_sounds)]
	
	volume_db = -10
	pitch_scale = 1.0
	_play_audio(audio)

func _play_axe_hit() -> void:
	volume_db = -15
	_play_audio(axe_hit_sfx)

func _play_goblin_death() -> void:
	volume_db = -5
	_play_audio(goblin_death_sfx)

func _play_audio(audio: AudioStream) -> void:
	stream = audio
	play()
