# main_menu.gd
extends Control

@onready var menu_box: NinePatchRect = $MenuBox
@onready var settings_panel: NinePatchRect = $SettingsPanel
@onready var credits_panel: NinePatchRect = $CreditsPanel
@onready var are_you_sure_box: NinePatchRect = $AreYouSureBox

func _ready() -> void:
	menu_box.play_button.pressed.connect(_on_play_button_pressed)
	menu_box.settings_button.pressed.connect(_on_settings_button_pressed)
	menu_box.credits_button.pressed.connect(_on_credits_button_pressed)
	menu_box.quit_button.pressed.connect(_on_quit_button_pressed)

	are_you_sure_box.yes_button.pressed.connect(_on_yes_button_pressed)
	are_you_sure_box.no_button.pressed.connect(_on_no_button_pressed)
	
	settings_panel.back_button.pressed.connect(_on_back_button_pressed)
	credits_panel.back_button.pressed.connect(_on_back_button_pressed)

### --- MENU BOX BUTTONS --- ###
func _on_play_button_pressed() -> void:
	SceneLoader.load_scene("uid://s1u2kmc7dn0d") # Load main game

func _on_settings_button_pressed() -> void:
	menu_box.visible = false
	settings_panel.visible = true
	credits_panel.visible = false
	are_you_sure_box.visible = false

func _on_credits_button_pressed() -> void:
	menu_box.visible = false
	settings_panel.visible = false
	credits_panel.visible = true
	are_you_sure_box.visible = false

func _on_quit_button_pressed() -> void:
	menu_box.visible = false
	settings_panel.visible = false
	credits_panel.visible = false
	are_you_sure_box.visible = true

### --- ARE YOU SURE POPUP BUTTONS --- ###
func _on_yes_button_pressed() -> void:
	get_tree().quit()

func _on_no_button_pressed() -> void:
	menu_box.visible = true
	settings_panel.visible = false
	credits_panel.visible = false
	are_you_sure_box.visible = false

### --- SETTINGS PANEL BUTTONS --- ###
func _on_back_button_pressed() -> void:
	menu_box.visible = true
	settings_panel.visible = false
	credits_panel.visible = false
	are_you_sure_box.visible = false
