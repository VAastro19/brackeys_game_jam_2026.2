# item.gd
class_name Item extends Area2D

@export var item_type: Enums.ItemType:
	set(new_value):
		item_type = new_value
		_update_item(new_value)

@onready var sprite: Sprite2D = $Sprite2D
@onready var collected_audio: AudioStreamPlayer = $CollectedSound
var atlas_texture: AtlasTexture

func _ready() -> void:
	body_entered.connect(_on_body_entered)
	body_exited.connect(_on_body_exited)
	
	EventBus.OnItemCollected.connect(_check_collection)
	
	if atlas_texture == null:
		atlas_texture = AtlasTexture.new()
	_update_item(item_type)

func _update_item(new_item: Enums.ItemType) -> void:
	var item_texture: Texture2D
	if new_item == Enums.ItemType.NONE:
		item_texture = load(ItemPath.path[Enums.ItemType.PUMPKIN]) # Change later
	else:
		item_texture = load(ItemPath.path[new_item])

	_load_texture(item_texture)

func _load_texture(new_texture: Texture2D) -> void:
	if atlas_texture == null:
		push_warning("Atlas not yet loaded")
		return
	if sprite == null:
		push_warning("Sprite not yet loaded")
		return
	atlas_texture.atlas = new_texture
	atlas_texture.region = Rect2(Vector2(0, 0), Vector2(16, 16))
	sprite.texture = atlas_texture

func _check_collection(collected_item: Item, _amount: int) -> void:
	if collected_item == self:
		sprite.visible = false
		collected_audio.play()
		await collected_audio.finished
		queue_free()

func _on_body_entered(body: Node2D) -> void:
	if body is Player:
		EventBus.OnItemClose.emit(self)

func _on_body_exited(body: Node2D) -> void:
	if body is Player:
		EventBus.OnItemFar.emit()
