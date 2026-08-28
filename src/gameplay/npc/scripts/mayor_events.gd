# mayor_events.gd
extends Node

@export_multiline var second_dialogue: Array[String]

@onready var mayor: NPC
var had_first_interaction: bool = false

func _ready() -> void:
	EventBus.OnEndInteraction.connect(_check_first_interaction)
	mayor = get_parent()

func _check_first_interaction(npc: NPC) -> void:
	if had_first_interaction:
		return
	if npc == mayor:
		had_first_interaction = true
		_update_dialogue(second_dialogue)

func _update_dialogue(new_dialogue_array: Array[String]) -> void:
	mayor.dialogue.dialogue_array = new_dialogue_array
