# elevated_area.gd
extends Area2D

@export var elevation_change: float = 200

func _ready() -> void:
	body_entered.connect(_increase_elevation)
	body_exited.connect(_decrease_elevation)

func _increase_elevation(body: CharacterBody2D) -> void:
	if not body is Entity:
		return
	body.velocity -= Vector2(0, elevation_change)

func _decrease_elevation(body: CharacterBody2D) -> void:
	if not body is Entity:
		return
	body.velocity += Vector2(0, elevation_change)
