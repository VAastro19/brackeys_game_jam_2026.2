# inentory_component.gd
class_name InventoryComponent extends Node

var inventory: Dictionary[Enums.ItemType, int] = {
	Enums.ItemType.APPLE: 0,
	Enums.ItemType.BREAD:  0,
	Enums.ItemType.CABBAGE:  0,
	Enums.ItemType.CARROT:  0,
	Enums.ItemType.DOUGH:  0,
	Enums.ItemType.FLOUR:  0,
	Enums.ItemType.EGG: 0,
	Enums.ItemType.ONION:  0,
	Enums.ItemType.PUMPKIN: 0,
	Enums.ItemType.PEPPER:  0,
	Enums.ItemType.MILK:  0,
	Enums.ItemType.TOMATO:  0,
	Enums.ItemType.WHEAT: 0
}

func _ready() -> void:
	EventBus.OnItemCollected.connect(_on_item_collected)
	EventBus.OnItemRemoved.connect(_on_item_removed)

func _on_item_collected(new_item: Item, amount: int) -> void:
	inventory[new_item.item_type] += amount

func _on_item_removed(item_type: Enums.ItemType, amount: int) -> void:
	inventory[item_type] -= amount
