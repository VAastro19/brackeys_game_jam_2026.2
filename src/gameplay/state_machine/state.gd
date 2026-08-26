# state.gd
class_name State extends Node

var entity: Entity
var state_machine: Node

func enter_state(entity_node) -> void:
	entity = entity_node
	state_machine = get_parent()

func exit_state() -> void:
	pass

func handle_input(_delta) -> void:
	pass
