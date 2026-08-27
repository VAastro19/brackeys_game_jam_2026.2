# input_prompt.gd
extends Control

@onready var interact_prompt: Control = $VBoxContainer/InteractPrompt

func _ready() -> void:
	EventBus.OnItemClose.connect(_show_interact_prompt)
	EventBus.OnItemFar.connect(_hide_interact_prompt)

func _show_interact_prompt(_item: Item) -> void:
	interact_prompt.visible = true

## THIS WILL CAUSE BUGS IF CROPS OVERLAP
func _hide_interact_prompt() -> void:
	interact_prompt.visible = false
