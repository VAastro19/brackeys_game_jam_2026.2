# weapon_component.gd
class_name WeaponComponent extends Node

@export var damage: int
@export var is_player: bool
@export var weapon_range: Area2D

func hit(combo: int = 1) -> void:
	for body in weapon_range.get_overlapping_bodies():
		if is_player:
			if body is Enemy:
				_deal_damage(body, combo)
		else:
			if body is Player:
				_deal_damage(body, combo)

func _deal_damage(body: Entity, combo: int) -> void:
	for i in range(combo):
		if not body.is_dead:
			body.get_node("HealthComponent").take_damage(damage)
			await get_tree().create_timer(0.07).timeout
