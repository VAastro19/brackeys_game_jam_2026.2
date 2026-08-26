# health_component.gd
class_name HealthComponent extends Node

@export var state_machine: Node
@export var max_health: int

signal OnHit(health: int, max_health: int)

var health: int

func _ready() -> void:
	health = max_health

func take_damage(damage: int) -> void:
	health -= maxi(0, damage)
	OnHit.emit(health, max_health)
	if health <= 0:
		state_machine.change_state(Enums.State.DEATH)
