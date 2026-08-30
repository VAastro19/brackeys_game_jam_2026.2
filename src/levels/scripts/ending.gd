# ending.gd
extends Node

@export var mason: NPC
@export var ending_talk: NPC

func _ready() -> void:
	EventBus.OnEndInteraction.connect(_end_the_game)
	
	await get_tree().create_timer(0.5).timeout
	EventBus.OnNPCInteracted.emit(mason)

func _end_the_game(npc: NPC) -> void:
	if npc == mason:
		await get_tree().create_timer(0.5).timeout
		EventBus.OnNPCInteracted.emit(ending_talk)
	else:
		SceneLoader.load_scene("uid://ci0ayyg4ero1o")
