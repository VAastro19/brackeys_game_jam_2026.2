# enemy.gd
class_name Enemy extends Entity

@export var max_speed: float = 100.0

@onready var sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var state_label: Label = $StateLabel
@onready var state_machine: Node = $StateMachine

var is_dead: bool = false

func _physics_process(delta: float) -> void:
	if state_machine.current_state and not is_dead:
		state_machine.current_state.handle_input(delta)
	state_label.text = Enums.State.keys()[state_machine.current_state_name].to_upper()
	move_and_slide()

func on_death() -> void:
	var loot_coins: int = randi_range(5, 15)
	EconomyManager.real_coins += loot_coins
	EventBus.OnCoinUpdate.emit(EconomyManager.real_coins, Enums.CoinType.REAL)
