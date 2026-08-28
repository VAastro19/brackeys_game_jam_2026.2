# enemy_walk_state.gd
extends State

@export var detection_zone: Area2D

@onready var player = get_tree().get_first_node_in_group("Player")

func enter_state(entity_node) -> void:
	super(entity_node)
	entity.sprite.play("walk")
	if player not in detection_zone.get_overlapping_bodies():
		state_machine.change_state(Enums.State.IDLE)

func handle_input(_delta) -> void:
	if not player:
		state_machine.change_state(Enums.State.IDLE)
		return
	var move_dir: Vector2 = (player.global_position - entity.global_position).normalized()
	
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

	EventBus.OnGoblinWalk.emit()

func _on_detection_zone_body_exited(body: Node2D) -> void:
	if not state_machine or entity.is_dead:
		return
	if body is Player:
		state_machine.change_state(Enums.State.IDLE)

func _on_weapon_range_body_entered(body: Node2D) -> void:
	if not state_machine or entity.is_dead:
		return
	if body is Player:
		state_machine.change_state(Enums.State.ATTACK1)
