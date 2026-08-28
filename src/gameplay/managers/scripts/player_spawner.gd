# player_spawner.gd
class_name PlayerSpawner extends Marker2D

@export var player: Player

func _ready() -> void:
	EventBus.OnPlayerDead.connect(_respawn_player)

func _respawn_player() -> void:
	var player_health_comp: HealthComponent = player.get_node("HealthComponent")
	player_health_comp.health = player_health_comp.max_health / 2
	EventBus.OnPlayerHit.emit(player_health_comp.health, player_health_comp.max_health)
	player.state_machine.change_state(Enums.State.IDLE)
	player.global_position = global_position
	player.is_dead = false
	player.modulate.a = 1.0
