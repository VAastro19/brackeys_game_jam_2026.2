# hud_root.gd
extends Control

@onready var coin_counters: Control = $CoinCounters
@onready var input_prompt: Control = $InputPrompt

@onready var pause_menu: Control = %PauseRoot

func _process(_delta: float) -> void:
	if pause_menu.visibility_changed:
		input_prompt.visible = !pause_menu.visible
		coin_counters.visible = !pause_menu.visible
