# enemy.gd
class_name Enemy extends Entity

@export var max_speed: float = 100.0

@onready var sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var state_label: Label = $StateLabel
@onready var state_machine: Node = $StateMachine
@onready var loot_coins_visual: HBoxContainer = $LootCoinsVisual
@onready var animation_player: AnimationPlayer = $AnimationPlayer

var is_dead: bool = false
var loot_coins: int

func _ready() -> void:
	loot_coins_visual.visible = false
	loot_coins = randi_range(5, 15)
	loot_coins_visual.get_node("CoinsLabel").text = "+" + str(loot_coins)

func _physics_process(delta: float) -> void:
	if state_machine.current_state and not is_dead:
		state_machine.current_state.handle_input(delta)
	state_label.text = Enums.State.keys()[state_machine.current_state_name].to_upper()
	move_and_slide()

func on_death() -> void:
	animation_player.play("death")
	EconomyManager.real_coins += loot_coins
	EventBus.OnCoinUpdate.emit(EconomyManager.real_coins, Enums.CoinType.REAL)
