# player_state.gd
class_name PlayerState extends Node

var player: Player
var state_machine: Node

func enter_state(player_node) -> void:
	player = player_node
	state_machine = get_parent()

func exit_state() -> void:
	pass

func _input(_delta) -> void:
	pass
