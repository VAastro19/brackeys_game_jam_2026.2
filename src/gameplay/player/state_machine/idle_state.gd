# idle_state.gd
extends PlayerState

func enter_state(player_node) -> void:
	super(player_node)

func handle_input(_delta) -> void:
	player.sprite.play("idle")

	if Input.is_action_just_pressed("action"):
		state_machine.change_state(Enums.State.ATTACK1)
	elif Input.get_vector("move_left", "move_right", "move_up", "move_down") != Vector2.ZERO:
		state_machine.change_state(Enums.State.WALK)
