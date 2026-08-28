# game_music.gd
extends Node

@onready var ambience: AudioStreamPlayer = $Ambience
@onready var music: AudioStreamPlayer = $Music
@onready var music_timer: Timer = $MusicTimer

@export var music_tracks: Array[AudioStream]

func _ready() -> void:
	_on_music_timer_timeout()

func _on_music_timer_timeout() -> void:
	var track = music_tracks[randi() % len(music_tracks)]
	music.stream = track
	music.play()

func _on_music_finished() -> void:
	music_timer.start()
