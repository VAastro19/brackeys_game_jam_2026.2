# shop_item.gd
class_name ShopItem extends Button

@onready var bought_sfx: AudioStreamPlayer = $BoughtSFX

@export var item_type: Enums.ItemType:
	set(new_value):
		item_type = new_value
		_set_shop_item.call_deferred(item_type)

@export var is_buy: bool = true:
	set(new_value):
		is_buy = new_value
		_set_button_text.call_deferred(is_buy)

@export var item_name: String:
	set(new_value):
		item_name = new_value
		_set_item_name(item_name)

@export_multiline() var description: String:
	set(new_value):
		description = new_value
		_set_description_text(description)

@export var price: int:
	set(new_value):
		if new_value < 0: price = 0
		elif new_value >= 1000: price = 999
		else: price = new_value
		_set_price(price)

@export var quantity: int:
	set(new_value):
		if new_value < 0: quantity = 0
		elif new_value >= 1000: quantity = 999
		else: quantity = new_value
		_set_quantity.call_deferred(quantity)

@onready var item_icon: TextureRect = $IconBackground/MarginContainer/ItemIcon
@onready var name_label: RichTextLabel = $Name
@onready var description_label: RichTextLabel = $Description
@onready var price_label: Label = $Price/PriceLabel
@onready var quantity_label: Label = $QuantityLabel
@onready var trade_all_button: Button = $TradeAllButton

func _ready() -> void:
	pressed.connect(_main_button_pressed)
	trade_all_button.pressed.connect(_on_all_button_pressed)

### --- BUTTON LOGIC --- ###
func _main_button_pressed() -> void:

	if not is_buy:
		var fake_coins: int = _calculate_fake_coins(price)
		EconomyManager.real_coins += price - fake_coins
		bought_sfx.play()

		EventBus.OnScammed.emit(fake_coins)
		EventBus.OnItemRemoved.emit(item_type, 1)
		EventBus.OnCoinUpdate.emit(EconomyManager.real_coins, Enums.CoinType.REAL)
	else:
		if EconomyManager.real_coins < price:
			EventBus.UIError.emit()
			return

		bought_sfx.play()
		EventBus.OnSlotUnlocked.emit()

	quantity -= 1
	if quantity <= 0:
		visible = false
		await bought_sfx.finished
		queue_free()

func _on_all_button_pressed() -> void:
	if not is_buy:
		var fake_coins: int = _calculate_fake_coins(price * quantity)
		EconomyManager.real_coins += (price * quantity) - fake_coins
		bought_sfx.play()

		EventBus.OnScammed.emit(fake_coins)
		EventBus.OnItemRemoved.emit(item_type, quantity)
		EventBus.OnCoinUpdate.emit(EconomyManager.real_coins, Enums.CoinType.REAL)
	else:
		if EconomyManager.real_coins < price * quantity:
			EventBus.UIError.emit()
			return

		bought_sfx.play()
		EventBus.OnSlotUnlocked.emit()
		EventBus.OnSlotUnlocked.emit()

	quantity = 0
	visible = false
	await bought_sfx.finished
	queue_free()

func _calculate_fake_coins(max_amount) -> int:
	var fake_coins: int = randi_range(0, max_amount)
	return fake_coins

### --- SETUP FUNCTIONS --- ###
func _set_shop_item(new_item: Enums.ItemType) -> void:
	var new_texture: Texture2D = load(ItemPath.path[new_item])
	item_icon.texture = new_texture
	item_name = ShopData.string_names[new_item]
	description = ShopData.descriptions[new_item]
	price = ShopData.item_prices[new_item]

func _set_button_text(new_value: bool) -> void:
	if new_value:
		trade_all_button.text = "Buy All"
	else:
		trade_all_button.text = "Sell All"

func _set_item_name(new_value: String) -> void:
	name_label.text = "[font_size=10][b][outline_size=3][color=b8a89a]" + new_value

func _set_description_text(new_value: String) -> void:
	description_label.text = "[font_size=10][outline_size=2]" + new_value

func _set_price(new_value: int) -> void:
	price_label.text = str(new_value)

func _set_quantity(new_value: int) -> void:
	quantity_label.text = str(new_value)
