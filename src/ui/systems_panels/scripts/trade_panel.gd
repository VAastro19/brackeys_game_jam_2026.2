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

var inventory_upgrades_quantity: int = 2
var forage_upgrades_quantity: int = 2
var damage_upgrades_quantity: int = 2

func _ready() -> void:
	EventBus.OnNPCInteracted.connect(_begin_trade)
	EventBus.OnScammed.connect(_update_trade_description)
	
	## Make it more sensible later
	EventBus.OnSlotUnlocked.connect(_slot_bought)
	EventBus.OnDamageIncreased.connect(_damage_bought)
	EventBus.OnForageIncreased.connect(_forage_bought)

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

	if not npc.is_seller:
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

func _slot_bought() -> void:
	inventory_upgrades_quantity -= 1

func _damage_bought() -> void:
	damage_upgrades_quantity -= 1

func _forage_bought() -> void:
	forage_upgrades_quantity -= 1

func _generate_merchant_shop_items() -> Array[ShopItem]:
	var arr: Array[ShopItem] = []
	if inventory_upgrades_quantity <= 0:
		return arr
	if interacted_npc.is_seller:
		var inventory_upgrade = shop_item_scene.instantiate()
		inventory_upgrade.item_type = Enums.ItemType.INVENTORY_UPGRADE
		inventory_upgrade.quantity = inventory_upgrades_quantity
		arr.append(inventory_upgrade)
		
		var increased_damage = shop_item_scene.instantiate()
		increased_damage.item_type = Enums.ItemType.INCREASED_DAMAGE
		increased_damage.quantity = damage_upgrades_quantity
		arr.append(increased_damage)
		
		var double_forage = shop_item_scene.instantiate()
		double_forage.item_type = Enums.ItemType.DOUBLE_FORAGE
		double_forage.quantity = forage_upgrades_quantity
		arr.append(double_forage)
		
	return arr

func _update_trade_description(fake_coins: int) -> void:
	if fake_coins <= 0:
		trade_description.text = label_settings + "Merchant paid the full price!"
	else:
		trade_description.text = label_settings + "Merchant gave you " + str(fake_coins) + " fake coins..."

func _on_back_button_pressed() -> void:
	_end_trade()
