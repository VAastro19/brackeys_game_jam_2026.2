# beginning_cutscene.gd
extends Control

@export var beginning: NPC

func _ready() -> void:
	await get_tree().create_timer(0.5).timeout
	EventBus.OnNPCInteracted.emit(beginning)
