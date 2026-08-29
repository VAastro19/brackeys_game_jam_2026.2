# interaction_root.gd
extends Control

@onready var dialogue_displayer: Control = $DialogueDisplayer
@onready var trade_panel: Control = $TradePanel

func _ready() -> void:
	EventBus.OnNPCInteracted.connect(_begin_interaction)
	EventBus.OnEndInteraction.connect(_end_interaction)

func _begin_interaction(npc: NPC) -> void:
	%HudRoot.visible = false
	if npc.is_merchant:
		trade_panel.visible = true
	else:
		dialogue_displayer.visible = true

func _end_interaction(_npc: NPC) -> void:
	dialogue_displayer.visible = false
	trade_panel.visible = false
	%HudRoot.visible = true
