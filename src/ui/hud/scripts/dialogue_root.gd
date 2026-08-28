# dialogue_root.gd
extends Control

@onready var dialogue_displayer: Control = $DialogueDisplayer
@onready var buy_panel: Control = $BuyPanel
@onready var sell_panel: Control = $SellPanel

func _ready() -> void:
	EventBus.OnNPCInteracted.connect(_begin_interaction)

func _begin_interaction(npc: NPC) -> void:
	if npc.is_merchant:
		if npc.is_seller:
			buy_panel.visible = true
		else:
			sell_panel.visible = true
	else:
		dialogue_displayer.visible = true

func _end_interaction() -> void:
	dialogue_displayer.visible = false
	buy_panel.visible = false
	sell_panel.visible = false
