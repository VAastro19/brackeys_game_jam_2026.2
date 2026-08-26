# damage_color_component.gd
extends Node
class_name DamageColorComponent

@onready var sprite: AnimatedSprite2D = get_parent()

@export var duration: float = 0.05 ## For how long in seconds should the sprite change color by default.
@export var color: Color = Color.RED ## Defines to what color should the sprite change to by default.

func _on_health_component_on_hit(_health: int, _max_health: int) -> void:
	sprite.self_modulate = color
	await get_tree().create_timer(duration).timeout
	sprite.self_modulate = Color.WHITE
