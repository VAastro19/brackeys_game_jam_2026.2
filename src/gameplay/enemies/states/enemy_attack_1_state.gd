# enemy_attack_1_state.gd
extends State

@export var weapon_component: WeaponComponent

func enter_state(entity_node) -> void:
	super(entity_node)
	entity.velocity = Vector2.ZERO

	entity.sprite.animation_finished.connect(_on_animation_finished)
	entity.sprite.play("attack_1")

func exit_state() -> void:
	EventBus.OnGoblinAttack.emit()
	weapon_component.hit(1)
	entity.sprite.animation_finished.disconnect(_on_animation_finished)

func _on_animation_finished() -> void:
	if state_machine.current_state == self:
		EventBus.OnGoblinAttack.emit()
		state_machine.change_state(Enums.State.ATTACK2)

func _on_weapon_range_body_exited(body: Node2D) -> void:
	if not state_machine or entity.is_dead:
		return
	if body is Player:
		state_machine.change_state(Enums.State.WALK)
