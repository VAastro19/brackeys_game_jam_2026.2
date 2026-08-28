# dialogue_displayer.gd
extends Control

@onready var label: Label = $MarginContainer/Label
@onready var blip_sound: AudioStreamPlayer = $BlipSound
@onready var timer: Timer = $LetterTimer

var ongoing_dialogue: bool = false
var interacted_npc: NPC = null
var last_index: int = 0

var max_pitch = 1.15
var min_pitch = 0.85

var dialogue_arr: Array[String] = []
var dialogue_index: int = 0:
	set(new_value):
		dialogue_index = new_value
		label.visible_characters = -1

func _ready() -> void:
	EventBus.OnNPCInteracted.connect(_begin_dialogue)
	label.text = ""
	timer.timeout.connect(_animate_dialogue)

func _begin_dialogue(npc: NPC) -> void:
	if ongoing_dialogue:
		_animate_dialogue()
		return

	dialogue_arr = npc.dialogue.dialogue_array
	interacted_npc = npc
	if dialogue_arr.is_empty():
		return

	if npc.dialogue.is_random:
		dialogue_index = randi_range(0, dialogue_arr.size() - 1)
		last_index = dialogue_index

	ongoing_dialogue = true
	_animate_dialogue()

func _animate_dialogue() -> void:
	# End dialogue after running once
	if interacted_npc.dialogue.is_random:
		if dialogue_index == last_index + 1: _end_dialogue()
	
	# End dialogue if run out of text
	if dialogue_index >= dialogue_arr.size():
		_end_dialogue.call_deferred()
		return

	label.text = dialogue_arr[dialogue_index]
	blip_sound.pitch_scale = randf_range(min_pitch, max_pitch)
	blip_sound.play()
	label.visible_characters += 1
	
	if label.visible_ratio == 1:
		dialogue_index += 1
	else:
		timer.start()

func _end_dialogue() -> void:
	EventBus.OnEndInteraction.emit(interacted_npc)
	interacted_npc = null
	ongoing_dialogue = false
	dialogue_index = 0
	last_index = 0
	label.text = ""
	dialogue_arr = []
