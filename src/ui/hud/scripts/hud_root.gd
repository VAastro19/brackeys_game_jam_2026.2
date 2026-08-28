# hud_root.gd
extends Control

@onready var pause_menu: Control = %PauseRoot

func _process(_delta: float) -> void:
	if pause_menu.visibility_changed:
		visible = !pause_menu.visible
