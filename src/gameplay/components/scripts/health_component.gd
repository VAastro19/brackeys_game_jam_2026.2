# health_component.gd
class_name HealthComponent extends Node

@export var state_machine: Node
@export var max_health: int
@export var allow_regeneration: bool = false
@export var regen_amount: int = 1

@onready var regen_cooldown_timer: Timer = $RegenCooldown

signal OnHit(health: int, max_health: int)

var health: int
var entity: Entity

func _ready() -> void:
	health = max_health
	entity = get_parent()

func take_damage(damage: int) -> void:
	if not entity.is_dead:
		health -= maxi(0, damage)
		OnHit.emit(health, max_health)
	
	if not regen_cooldown_timer.is_stopped():
		regen_cooldown_timer.start()
	if allow_regeneration:
		allow_regeneration = false
		regen_cooldown_timer.start()
	
	if health <= 0:
		entity.on_death()
		state_machine.change_state(Enums.State.DEATH)

func regenerate() -> void:
	if allow_regeneration:
		if health < max_health:
			health = min(health + regen_amount, max_health)
			OnHit.emit(health, max_health)

func _on_regen_cooldown() -> void:
	allow_regeneration = true
