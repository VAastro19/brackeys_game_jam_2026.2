# coin_counter.gd
extends Control

@export var coin_type: Enums.CoinType
@export var coin_amount: int = 0:
	set(new_value):
		if new_value > 0:
			coin_amount = new_value
			_update_counter(new_value)

@onready var coin_sprite: AnimatedSprite2D = $HBoxContainer/CoinTexture/AnimatedSprite2D
@onready var coin_amount_label: Label = $HBoxContainer/CoinAmountLabel

func _ready() -> void:
	EventBus.OnCoinUpdate.connect(_on_coin_gain)
	if coin_type == Enums.CoinType.FAKE:
		coin_sprite.modulate = Color.CHOCOLATE

func _on_coin_gain(amount: int, type: Enums.CoinType) -> void:
	if coin_type == type:
		coin_amount = amount
		_update_counter(coin_amount)

func _update_counter(new_value: int) -> void:
	coin_amount_label.text = str(new_value)
