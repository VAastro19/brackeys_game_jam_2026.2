# player.gd
class_name Player extends Entity

@onready var sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var state_label: Label = $StateLabel

@onready var state_machine: Node = $StateMachine

func _physics_process(delta: float) -> void:
	if state_machine.current_state:
		state_machine.current_state.handle_input(delta)
	state_label.text = Enums.State.keys()[state_machine.current_state_name].to_upper()
	move_and_slide()
