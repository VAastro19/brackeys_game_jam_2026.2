# pause_root.gd
extends Control

@onready var settings_panel: NinePatchRect = $SettingsPanel
@onready var are_you_sure_box: NinePatchRect = $AreYouSureBox
@onready var corner_details: Control = $CornerDetails

func _ready() -> void:
	settings_panel.back_button.pressed.connect(_on_quit_button_pressed)
	are_you_sure_box.yes_button.pressed.connect(_on_yes_button_pressed)
	are_you_sure_box.no_button.pressed.connect(_on_no_button_pressed)

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_cancel"):
		settings_panel.visible = true
		are_you_sure_box.visible = false
		visible = !visible

func _on_quit_button_pressed() -> void:
	settings_panel.visible = false
	are_you_sure_box.visible = true

func _on_yes_button_pressed() -> void:
	are_you_sure_box.visible = false
	corner_details.visible = false
	SceneLoader.load_scene("uid://ci0ayyg4ero1o") # Load main menu

func _on_no_button_pressed() -> void:
	settings_panel.visible = true
	are_you_sure_box.visible = false
