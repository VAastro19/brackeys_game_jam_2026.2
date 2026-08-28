# sell_panel.gd
extends Control

var interacted_npc: NPC = null
var ongoing_trade: bool = false

func _ready() -> void:
	EventBus.OnNPCInteracted.connect(_begin_trade)

func _begin_trade(npc: NPC) -> void:
	if ongoing_trade:
		_end_trade.call_deferred()
	if not npc.is_merchant:
		return
	interacted_npc = npc
	ongoing_trade = true

func _end_trade() -> void:
	EventBus.OnEndInteraction.emit(interacted_npc)
	interacted_npc = null
	ongoing_trade = false
