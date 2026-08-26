# enemy_health_bar.gd
extends Control

@export var health_component: HealthComponent

@onready var health_bar: ProgressBar = $ProgressBar

func _ready() -> void:
	health_component.OnHit.connect(_on_hit)
	health_bar.max_value = health_component.max_health
	health_bar.min_value = 0
	health_bar.value = 0

func _on_hit(health: int, max_health: int) -> void:
	health_bar.value = max_health - health
