# enemy_spawner.gd
class_name EnemySpawner extends Marker2D

@export var enemy_scene: PackedScene
@export var respawn_time: float = 5.0
@export var entity_root: Node2D

@onready var notifier: VisibleOnScreenNotifier2D = $VisibleOnScreenNotifier2D
@onready var respawn_timer: Timer = $RespawnTimer

var enemy: Entity = null
@export var can_spawn: bool = false

func _ready() -> void:
	respawn_timer.wait_time = respawn_time

func spawn_enemy() -> void:
	print("spawning enemy")
	enemy = enemy_scene.instantiate()
	can_spawn = false
	enemy.global_position = global_position
	entity_root.add_child(enemy)

func _on_respawn_timer_timeout() -> void:
	print("can spawn!")
	can_spawn = true

func _on_visible_on_screen() -> void:
	if can_spawn:
		spawn_enemy()

func _on_refresh_timer_timeout() -> void:
	if enemy == null:
		if respawn_timer.is_stopped():
			respawn_timer.one_shot = true
			respawn_timer.start()
