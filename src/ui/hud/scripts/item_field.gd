# item_field.gd
class_name ItemField extends TextureRect

@export var item_type: Enums.ItemType:
	set(new_value):
		_update_item(new_value)
		item_type = new_value

@export var is_unlocked: bool = true:
	set(new_value):
		_change_item_lock(new_value)
		is_unlocked = new_value

@export var item_count: int = 0:
	set(new_value):
		_update_item_count(new_value)
		if new_value >= 100:
			item_count = 99
		elif new_value <= 0:
			item_count = 0
		else:
			item_count = new_value

@onready var item_texture_rect: TextureRect = $MarginContainer/ItemTextureRect
@onready var item_count_label: Label = $ItemCountLabel

var atlas_texture: AtlasTexture

func _ready() -> void:
	EventBus.OnItemRemoved.connect(_remove_item)
	if atlas_texture == null:
		atlas_texture = AtlasTexture.new()
	_update_item(item_type)
	_update_item_count(item_count)

func _remove_item(type: Enums.ItemType, amount: int) -> void:
	if not type == item_type:
		return
	item_count -= amount

func _update_item(new_item: Enums.ItemType) -> void:
	if new_item == Enums.ItemType.NONE:
		item_texture_rect.texture = null

	else:
		if new_item != item_type:
			var item_texture: Texture2D = load(ItemPath.path[new_item])
			_load_texture(item_texture)

func _load_texture(new_texture: Texture2D) -> void:
	if atlas_texture == null:
		push_warning("Atlas not yet loaded")
		return
	if item_texture_rect == null:
		push_warning("Texture Rect not yet loaded")
		return
	if is_unlocked:
		atlas_texture.atlas = new_texture
		atlas_texture.region = Rect2(Vector2(0, 0), Vector2(16, 16))
		item_texture_rect.texture = atlas_texture

func _update_item_count(new_value: int) -> void:
	if item_count_label == null:
		push_warning("Label not yet loaded")
		return
	if new_value <= 0:
		item_count_label.text = "0"
		item_type = Enums.ItemType.NONE
		item_count_label.visible = false
	elif new_value >= 100:
		item_count_label.visible = true
		item_count_label.text = "99"
	else:
		item_count_label.visible = true
		item_count_label.text = str(new_value)

func _change_item_lock(new_value: bool) -> void:
	visible = new_value
