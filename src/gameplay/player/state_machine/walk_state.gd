# walk_state.gd
extends PlayerState

func enter_state(player_node) -> void:
	super(player_node)

func handle_input(_delta) -> void:
	player.sprite.play("walk")
	
	var move_dir: Vector2 = Input.get_vector("move_left", "move_right", "move_up", "move_down")
	
	# Smooth movement
	if move_dir.length() > 0:
		player.velocity = player.velocity.lerp(move_dir * player.max_speed, player.acceleration)
	else:
		player.velocity = player.velocity.lerp(Vector2.ZERO, player.braking)
	
	# Flip sprite
	if move_dir.x < 0:
		player.sprite.flip_h = true
	elif move_dir.x > 0:
		player.sprite.flip_h = false
	
	player.velocity = move_dir * player.max_speed
	
	if Input.is_action_just_pressed("action"):
		state_machine.change_state(Enums.State.ATTACK1)
	if move_dir == Vector2.ZERO:
		state_machine.change_state(Enums.State.IDLE)
