# player_attack_2_state.gd
extends State

@export var weapon_component: WeaponComponent
var combo_sustained: bool

func enter_state(entity_node) -> void:
	super(entity_node)
	entity.velocity = Vector2.ZERO

	entity.sprite.animation_finished.connect(_on_animation_finished)
	entity.sprite.play("attack_2")
	EventBus.OnPlayerAttack2.emit()

func handle_input(_delta) -> void:
	if entity.sprite.is_playing():
		if Input.is_action_just_pressed("action"):
			combo_sustained = true

func exit_state() -> void:
	weapon_component.hit(3)
	entity.sprite.animation_finished.disconnect(_on_animation_finished)
	combo_sustained = false

func _on_animation_finished() -> void:
	if combo_sustained:
		state_machine.change_state(Enums.State.ATTACK3)
	else:
		state_machine.change_state(Enums.State.IDLE)
