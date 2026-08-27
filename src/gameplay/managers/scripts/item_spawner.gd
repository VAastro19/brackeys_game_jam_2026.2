# item_spawner.gd
class_name ItemSpawner extends Marker2D

@export var type: Enums.ItemType
@export var respawn_time: float = 120.0

@onready var item_scene: PackedScene = preload("uid://c30nbb53rba26")
@onready var collectible_root: Node2D = $"../../CollectibleRoot"
@onready var notifier: VisibleOnScreenNotifier2D = $VisibleOnScreenNotifier2D
@onready var respawn_timer: Timer = $RespawnTimer

var item: Item = null
var can_spawn: bool

func _ready() -> void:
	respawn_timer.wait_time = respawn_time

func spawn_item() -> void:
	print("Spawn item")
	item = item_scene.instantiate()
	item.global_position = global_position
	item.item_type = type
	collectible_root.add_child(item)
	can_spawn = false

func _on_respawn_timer_timeout() -> void:
	print("timer finished")
	can_spawn = true

func _on_visible_on_screen() -> void:
	print("screen entered")
	if can_spawn and not item:
		spawn_item()

func _on_refresh_timer_timeout() -> void:
	if not item:
		if respawn_timer.is_stopped():
			respawn_timer.one_shot = true
			respawn_timer.start()
