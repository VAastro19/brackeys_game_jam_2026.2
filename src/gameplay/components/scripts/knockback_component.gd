# knockback_component.gd
class_name KnockbackComponent extends Node

@export var force: int
var parent: Entity
var player: Entity

func _ready() -> void:
	parent = get_parent()
	player = get_tree().get_first_node_in_group("Player")

func _on_health_component_on_hit(_health: int, _max_health: int) -> void:
	var move_dir: Vector2 = (parent.global_position - player.global_position).normalized()
	parent.velocity += move_dir * force

	
