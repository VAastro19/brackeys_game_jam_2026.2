# ending_cutscene.gd
extends Control

func _ready() -> void:
	EventBus.OnEndGame.connect(show_ending_cutscene)

func show_ending_cutscene() -> void:
	EconomyManager.real_coins -= 2000
	SceneLoader.load_scene("uid://dtgw4a3wtlhj")
