# player_idle_state.gd
extends State

func enter_state(entity_node) -> void:
	super(entity_node)
	entity.velocity = Vector2.ZERO

func handle_input(_delta) -> void:
	entity.sprite.play("idle")

	if Input.is_action_just_pressed("action"):
		state_machine.change_state(Enums.State.ATTACK1)
	elif Input.get_vector("move_left", "move_right", "move_up", "move_down") != Vector2.ZERO:
		state_machine.change_state(Enums.State.WALK)
