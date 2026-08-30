# trade_panel.gd
extends Control

@onready var shop_item_scene: PackedScene = preload("uid://4h8www4hr1dg")

@onready var back_button: Button = $BackButton
@onready var player_area: NinePatchRect = $PlayerArea
@onready var merchant_area: NinePatchRect = $MerchantArea
@onready var trade_description: RichTextLabel = $TradeDescription

var label_settings: String = "[font_size=12][b][outline_size=3][color=b8a89a]"

var player: Player
var interacted_npc: NPC = null
var ongoing_trade: bool = false

var upgrades_quantity: int = 2

func _ready() -> void:
	EventBus.OnNPCInteracted.connect(_begin_trade)
	EventBus.OnScammed.connect(_update_trade_description)
	EventBus.OnSlotUnlocked.connect(_FRANKENSTEIN_BUY)

	back_button.pressed.connect(_on_back_button_pressed)
	player = get_tree().get_first_node_in_group("Player")

func _begin_trade(npc: NPC) -> void:
	if ongoing_trade:
		_end_trade.call_deferred()
	if not npc.is_merchant:
		return

	trade_description.text = ""
	interacted_npc = npc
	ongoing_trade = true

	player_area.items = _generate_player_shop_items()
	player_area.setup_trade_area()
	
	merchant_area.items = _generate_merchant_shop_items()
	merchant_area.setup_trade_area()

func _end_trade() -> void:
	player_area.clean_trade_area()
	merchant_area.clean_trade_area()
	
	EventBus.OnEndInteraction.emit(interacted_npc)
	interacted_npc = null
	ongoing_trade = false

func _generate_player_shop_items() -> Array[ShopItem]:
	var arr: Array[ShopItem] = []
	var player_inventory = player.inventory_component.inventory

	for item in player_inventory:
		if player_inventory[item] <= 0:
			continue
		var shop_item = shop_item_scene.instantiate()
		shop_item.item_type = item
		shop_item.quantity = player_inventory[item]
		arr.append(shop_item)
	
	return arr

func _FRANKENSTEIN_BUY() -> void:
	upgrades_quantity -= 1

func _generate_merchant_shop_items() -> Array[ShopItem]:
	var arr: Array[ShopItem] = []
	if upgrades_quantity <= 0:
		return arr
	if interacted_npc.is_seller:
		var shop_item = shop_item_scene.instantiate()
		shop_item.item_type = Enums.ItemType.INVENTORY_UPGRADE
		shop_item.quantity = upgrades_quantity
		arr.append(shop_item)
	return arr

func _update_trade_description(fake_coins: int) -> void:
	if fake_coins <= 0:
		trade_description.text = label_settings + "Merchant paid the full price!"
	else:
		trade_description.text = label_settings + "Merchant gave you " + str(fake_coins) + " fake coins..."

func _on_back_button_pressed() -> void:
	_end_trade()
