# attack_1_state.gd
extends PlayerState

func enter_state(player_node) -> void:
	super(player_node)
	player.velocity = Vector2.ZERO
	player.sprite.play("attack_1")

func handle_input(_delta) -> void:

	if player.sprite.is_playing():
		if Input.is_action_just_pressed("action"):
			await player.sprite.animation_finished
			state_machine.change_state(Enums.State.ATTACK2)

	else:
		state_machine.change_state(Enums.State.IDLE)
