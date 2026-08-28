# wizard_events.gd
extends Node

@onready var wizard: NPC
var had_first_interaction: bool = false

func _ready() -> void:
	EventBus.OnEndInteraction.connect(_check_first_interaction)
	wizard = get_parent()

func _check_first_interaction(npc: NPC) -> void:
	if had_first_interaction:
		return
	if npc == wizard:
		had_first_interaction = true
		_change_to_merchant()

func _change_to_merchant() -> void:
	wizard.is_merchant = true
	wizard.is_seller = true
	wizard.dialogue.dialogue_array.clear()
