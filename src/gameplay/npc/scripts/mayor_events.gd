# mayor_events.gd
extends Node

@export_multiline var second_dialogue: Array[String]
@export_multiline var third_dialogue: Array[String]

@onready var mayor: NPC
var had_first_interaction: bool = false
var had_last_interaction: bool = false
var has_money: bool = false
var end_dialogue_active: bool = false

func _ready() -> void:
	EventBus.OnEndInteraction.connect(_on_end_interaction)
	mayor = get_parent()

func _process(_delta: float) -> void:
	if had_first_interaction:
		_check_coin_status()

func _on_end_interaction(npc: NPC) -> void:
	if npc != mayor:
		return

	if end_dialogue_active:
		had_last_interaction = true
		EventBus.OnEndGame.emit()
		return

	if not had_first_interaction:
		had_first_interaction = true

func _check_coin_status() -> void:
	if EconomyManager.real_coins >= 2000:
		end_dialogue_active = true
		_update_dialogue(third_dialogue)
	else:
		end_dialogue_active = false
		_update_dialogue(second_dialogue)

func _update_dialogue(new_dialogue_array: Array[String]) -> void:
	mayor.dialogue.dialogue_array = new_dialogue_array
