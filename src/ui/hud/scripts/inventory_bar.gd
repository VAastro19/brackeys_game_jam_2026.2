# inventory_bar.gd
class_name InventoryBar extends Control

@onready var placeholder: HBoxContainer = $MarginContainer/HBoxContainer
@onready var slots: Array = []

func _ready() -> void:
	EventBus.OnSlotUnlocked.connect(_unlock_slot)
	slots = placeholder.get_children()

func _unlock_slot() -> void:
	for slot in slots:
		if not slot.is_unlocked:
			slot.is_unlocked = true
			return

func try_add_item(collected_item: Enums.ItemType) -> bool:
	var found_slot: bool = false
	var free_slot: ItemField = null
	for slot in slots:
		
		# Skip not unlocked slots
		if not slot.is_unlocked:
			continue

		# If found item of same type, break the loop and add it
		if slot.item_type == collected_item:
			slot.item_type = collected_item
			return true

		# Skip filled slots of different type
		elif not slot.item_type == Enums.ItemType.NONE:
			continue

		# If found empty slot keep it for later (same type filled slots priority)
		else:
			if free_slot == null: free_slot = slot
			found_slot = true

	# If slot with the same item type was not found, add it to the first free slot found or deny
	if found_slot:
		free_slot.item_type = collected_item
		return true
	else:
		return false
