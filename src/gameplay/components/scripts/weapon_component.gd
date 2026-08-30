# weapon_component.gd
class_name WeaponComponent extends Node

@export var damage: int
@export var multiplier: int = 1
@export var is_player: bool
@export var weapon_range: Area2D

func _ready() -> void:
	EventBus.OnDamageIncreased.connect(_increase_damage)

func hit(combo: int = 1) -> void:
	for body in weapon_range.get_overlapping_bodies():
		if is_player:
			if body is Enemy:
				_deal_damage(body, combo)
		else:
			if body is Player:
				_deal_damage(body, combo)

func _increase_damage() -> void:
	multiplier += 1

func _deal_damage(body: Entity, combo: int) -> void:
	for i in range(combo):
		if not body.is_dead:
			body.get_node("HealthComponent").take_damage(damage * multiplier)
			await get_tree().create_timer(0.07).timeout
