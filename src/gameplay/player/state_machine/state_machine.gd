# state_machine.gd
extends Node

@onready var player: Player = get_parent()
@export var current_state_name: Enums.State

var current_state: PlayerState

func _ready() -> void:
	change_state(Enums.State.IDLE)

func change_state(new_state_name: Enums.State) -> void:
	if current_state:
		current_state.exit_state()
	current_state_name = new_state_name
	current_state = get_node(Enums.State.keys()[current_state_name].to_pascal_case() + "State")
	if current_state:
		current_state.enter_state(player)
