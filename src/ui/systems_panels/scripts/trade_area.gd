# trade_area.gd
extends NinePatchRect

@export var is_buy: bool = true
@export var items: Array[ShopItem] = []

@onready var buttons_container: VBoxContainer = $CentralContainer/ScrollContainer/ButtonsContainer
@onready var trade_type_label: RichTextLabel = $TradeTypeLabel

var label_settings: String = "[color=black][outline_size=2][outline_color=b8a89a][i]"

func _ready() -> void:
	if is_buy:
		trade_type_label.text = label_settings + "Buy:"
	else:
		trade_type_label.text = label_settings + "Sell:"

func setup_trade_area() -> void:
	for item in items:
		if item is ShopItem:
			item.is_buy = is_buy
			add_shop_item(item)

func clean_trade_area() -> void:
	for child in buttons_container.get_children():
		child.queue_free()
	items.clear()

func add_shop_item(shop_item: ShopItem) -> void:
	buttons_container.add_child(shop_item)
