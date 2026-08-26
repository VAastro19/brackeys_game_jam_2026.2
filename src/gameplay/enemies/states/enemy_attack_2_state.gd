# enemy_attack_2_state.gd
extends State

@export var weapon_component: WeaponComponent

func enter_state(entity_node) -> void:
	super(entity_node)
	entity.velocity = Vector2.ZERO

	entity.sprite.animation_finished.connect(_on_animation_finished)
	entity.sprite.play("attack_2")

func exit_state() -> void:
	weapon_component.hit(1)
	entity.sprite.animation_finished.disconnect(_on_animation_finished)

func _on_animation_finished() -> void:
	if state_machine.current_state == self:
		state_machine.change_state(Enums.State.ATTACK1)

func _on_weapon_range_body_exited(body: Node2D) -> void:
	if not state_machine or entity.is_dead:
		return
	if body is Player:
		state_machine.change_state(Enums.State.WALK)
