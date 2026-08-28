# player.gd
class_name Player extends Entity

@export var max_speed: float = 200.0
@export var inventory_bar: InventoryBar

@onready var sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var state_label: Label = $StateLabel

@onready var state_machine: Node = $StateMachine
@onready var animation_player: AnimationPlayer = $AnimationPlayer

var can_collect: bool = false
var nearby_item: Item = null
var is_dead: bool = false
var can_move: bool = true

func _ready() -> void:
	EventBus.OnItemClose.connect(_item_close)
	EventBus.OnItemFar.connect(_item_far)
	EventBus.OnNPCInteracted.connect(_interaction_lock)
	EventBus.OnEndInteraction.connect(_interaction_unlock)
	
	$InventoryFullLabel.visible = false

func _physics_process(delta: float) -> void:
	if state_machine.current_state:
		state_machine.current_state.handle_input(delta)
	state_label.text = Enums.State.keys()[state_machine.current_state_name].to_upper()
	move_and_slide()

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("interact"):
		if can_collect: collect()

func collect() -> void:
	if nearby_item == null:
		return
	if inventory_bar.try_add_item(nearby_item.item_type):
		EventBus.OnItemCollected.emit(nearby_item, 1)
	else:
		EventBus.UIError.emit()
		animation_player.play("inventory_full")

func _item_close(item: Item) -> void:
	can_collect = true
	nearby_item = item

func _item_far() -> void:
	can_collect = false
	nearby_item = null

func _interaction_lock(_npc: NPC) -> void:
	can_move = false
	state_machine.change_state(Enums.State.IDLE)

func _interaction_unlock(_npc: NPC) -> void:
	can_move = true

func on_death() -> void:
	EconomyManager.real_coins = roundi(EconomyManager.real_coins * 0.8)
	EconomyManager.fake_coins = roundi(EconomyManager.fake_coins * 0.8)
	EventBus.OnCoinUpdate.emit(EconomyManager.real_coins, Enums.CoinType.REAL)
	EventBus.OnCoinUpdate.emit(EconomyManager.fake_coins, Enums.CoinType.FAKE)

func _on_health_component_hit(health: int, max_health: int) -> void:
	EventBus.OnPlayerHit.emit(health, max_health)
