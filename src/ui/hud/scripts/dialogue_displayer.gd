# dialogue_displayer.gd
extends Control

@onready var label: Label = $MarginContainer/Label
@onready var timer: Timer = $LetterTimer
@onready var dialogue_base: Node = $DialogueBase

var dialogue_index: int = 0:
	set(new_value):
		dialogue_index = new_value
		label.visible_characters = -1

func _ready() -> void:
	label.text = ""
	timer.timeout.connect(_animate_dialogue)
	
	_animate_dialogue()

func _animate_dialogue() -> void:
	if dialogue_index >= dialogue_base.dialogue_array.size():
		return

	label.text = dialogue_base.dialogue_array[dialogue_index]
	label.visible_characters += 1

	if label.visible_ratio == 1:
		dialogue_index += 1
	else:
		timer.start()
