# enemy_idle_state.gd
extends State

func enter_state(entity_node) -> void:
	super(entity_node)
	entity.velocity = Vector2.ZERO

func handle_input(_delta) -> void:
	entity.sprite.play("idle")

func _on_detection_zone_body_entered(body: Node2D) -> void:
	if not state_machine or entity.is_dead:
		return
	if body is Player:
		state_machine.change_state(Enums.State.WALK)
