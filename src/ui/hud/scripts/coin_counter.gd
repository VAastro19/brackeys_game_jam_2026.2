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
	if coin_type == Enums.CoinType.FAKE:
		coin_sprite.modulate = Color.BROWN

func _update_counter(new_value: int) -> void:
	coin_amount_label.text = str(new_value)
