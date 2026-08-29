# shop_item.gd
class_name ShopItem extends Button

@export var icon_texture: Texture2D:
	set(new_value):
		icon_texture = new_value
		_set_texture(icon_texture)

@export var is_buy: bool = true:
	set(new_value):
		is_buy = new_value
		_set_button_text(is_buy)

@export var item_name: String = "Item Name":
	set(new_value):
		item_name = new_value
		_set_item_name(description)

@export_multiline() var description: String = "Example description of an item":
	set(new_value):
		description = new_value
		_set_description_text(description)

@export var price: int = 15:
	set(new_value):
		if new_value < 0: price = 0
		elif new_value >= 1000: price = 999
		else: price = new_value
		_set_price(price)

@export var quantity: int = 1:
	set(new_value):
		if new_value < 0: quantity = 0
		elif new_value >= 1000: quantity = 999
		else: quantity = new_value
		_set_quantity(quantity)

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
	pass

func _on_all_button_pressed() -> void:
	pass

### --- SETUP FUNCTIONS --- ###
func _set_texture(new_texture: Texture2D) -> void:
	item_icon.texture = new_texture

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
