# item_field.gd
class_name ItemField extends TextureRect

@export var item: Enums.Crop:
	set(new_value):
		item = new_value
		_update_crop(new_value)
@export var is_unlocked: bool = true:
	set(new_value):
		is_unlocked = new_value
		_change_item_lock(new_value)
@export var item_count: int = 0:
	set(new_value):
		if new_value >= 100:
			item_count = 99
		elif new_value <= 0:
			item_count = 0
		else:
			item_count = new_value
		_update_item_count(new_value)

@onready var item_texture_rect: TextureRect = $MarginContainer/ItemTextureRect
@onready var item_count_label: Label = $ItemCountLabel

var atlas_texture: AtlasTexture

func _ready() -> void:
	atlas_texture = AtlasTexture.new()
	if item_count <= 0:
		_update_item_count(0)

func _update_crop(new_crop: Enums.Crop) -> void:
	if new_crop == Enums.Crop.NONE:
		item_texture_rect.texture = null
	else:
		var item_texture: Texture2D = load(CropPath.path[new_crop])
		_load_texture(item_texture)
		if item_count <= 0:
			item_count = 1

func _load_texture(new_texture: Texture2D) -> void:
	if is_unlocked:
		atlas_texture.atlas = new_texture
		atlas_texture.region = Rect2(Vector2(0, 0), Vector2(16, 16))
		item_texture_rect.texture = atlas_texture

func _update_item_count(new_value: int) -> void:
	if new_value <= 0:
		item_count_label.text = "0"
		item = Enums.Crop.NONE
		item_count_label.visible = false
	elif new_value >= 100:
		item_count_label.visible = true
		item_count_label.text = "99"
	else:
		item_count_label.visible = true
		item_count_label.text = str(new_value)

func _change_item_lock(new_value: bool) -> void:
	visible = new_value
