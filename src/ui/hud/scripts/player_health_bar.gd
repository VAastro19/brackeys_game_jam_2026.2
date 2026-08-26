# player_health_bar.gd
extends Control

@onready var health_bar: ProgressBar = $MarginContainer/ProgressBar
var player: Player

func _ready() -> void:
	EventBus.OnPlayerHit.connect(_on_hit)
	player = get_tree().get_first_node_in_group("Player")
	health_bar.max_value = player.get_node("HealthComponent").max_health
	health_bar.min_value = 0
	health_bar.value = 0

func _on_hit(health: int, max_health: int) -> void:
	health_bar.value = max_health - health
