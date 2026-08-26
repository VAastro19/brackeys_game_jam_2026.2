# player_walk_state.gd
extends State

func enter_state(entity_node) -> void:
	super(entity_node)

func handle_input(_delta) -> void:
	entity.sprite.play("walk")
	
	var move_dir: Vector2 = Input.get_vector("move_left", "move_right", "move_up", "move_down")
	
	# Smooth movement
	if move_dir.length() > 0:
		entity.velocity = entity.velocity.lerp(move_dir * entity.max_speed, entity.acceleration)
	else:
		entity.velocity = entity.velocity.lerp(Vector2.ZERO, entity.braking)
	
	# Flip sprite
	if move_dir.x < 0:
		entity.sprite.flip_h = true
	elif move_dir.x > 0:
		entity.sprite.flip_h = false
	
	if Input.is_action_just_pressed("action"):
		state_machine.change_state(Enums.State.ATTACK1)
	if move_dir == Vector2.ZERO:
		state_machine.change_state(Enums.State.IDLE)
