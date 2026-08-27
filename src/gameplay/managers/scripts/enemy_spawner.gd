# enemy_spawner.gd
class_name EnemySpawner extends Marker2D

@export var respawn_time: float = 5.0

@onready var enemy_scene: PackedScene = preload("uid://dac5jpr024ka1") # Goblin
@onready var entity_root: Node2D = $"../../EntityRoot"
@onready var notifier: VisibleOnScreenNotifier2D = $VisibleOnScreenNotifier2D
@onready var respawn_timer: Timer = $RespawnTimer

var enemy: Entity = null
var can_spawn: bool

func _ready() -> void:
	respawn_timer.wait_time = respawn_time

func spawn_enemy() -> void:
	enemy = enemy_scene.instantiate()
	enemy.global_position = global_position
	entity_root.add_child(enemy)
	can_spawn = false

func _on_respawn_timer_timeout() -> void:
	can_spawn = true

func _on_visible_on_screen() -> void:
	if can_spawn and not enemy:
		spawn_enemy()

func _on_refresh_timer_timeout() -> void:
	if not enemy:
		if respawn_timer.is_stopped():
			respawn_timer.one_shot = true
			respawn_timer.start()
