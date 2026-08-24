# settings_panel.gd
extends NinePatchRect

@export var button_name: String = "Back"

@onready var back_button: Button = $MarginContainer/VBoxContainer/BackButton
@onready var resolutions_button: OptionButton = $MarginContainer/VBoxContainer/ResolutionsButton
@onready var fullscreen_button: CheckBox = $MarginContainer/VBoxContainer/FullscreenButton
@onready var master_slider: HSlider = $MarginContainer/VBoxContainer/SlidersVBoxContainer/MasterSlider
@onready var music_slider: HSlider = $MarginContainer/VBoxContainer/SlidersVBoxContainer/MusicSlider
@onready var sfx_slider: HSlider = $MarginContainer/VBoxContainer/SlidersVBoxContainer/SFXSlider

var resolutions = {
	"3840x2160": Vector2i(3840,2160),
	"2560x1440": Vector2i(2560,1440),
	"1920x1080": Vector2i(1920,1080),
	"1600x900": Vector2i(1600,900),
	"1440x900": Vector2i(1440,900),
	"1366x768": Vector2i(1366,768),
	"1280x720": Vector2i(1280,720),
	"1024x600": Vector2i(1024,600),
	"800x600": Vector2i(800,600),
	"640x360": Vector2i(640,360)
}

var master_index: int
var music_index: int
var sfx_index: int

func _ready() -> void:
	if DisplayServer.window_get_mode() == DisplayServer.WINDOW_MODE_FULLSCREEN:
		fullscreen_button.button_pressed = true
	
	master_index = AudioServer.get_bus_index("Master")
	music_index = AudioServer.get_bus_index("Music")
	sfx_index = AudioServer.get_bus_index("SFX")
	
	master_slider.value = _get_volume(master_index)
	music_slider.value = _get_volume(music_index)
	sfx_slider.value = _get_volume(sfx_index)
	
	back_button.text = button_name
	
	# Initial reesolution for ease of life
	_on_resolutions_button_item_selected(6)

###  --- FULLSCREEN BUTTON --- ###
func _on_fullscreen_toggled(toggled_on: bool) -> void:
	if toggled_on:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
	else:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)

###  --- RESOLUTIONS BUTTON --- ###
func _center_window() -> void:
	var screen_center: Vector2i = DisplayServer.screen_get_position() + DisplayServer.screen_get_size() / 2
	var window_size: Vector2i = get_window().get_size_with_decorations()
	get_window().set_position(screen_center - window_size / 2)

func _on_resolutions_button_item_selected(index: int) -> void:
	var key: String = resolutions_button.get_item_text(index)
	get_window().set_size(resolutions[key])
	_center_window()

###  --- AUDIO SLIDERS --- ###
func _get_volume(bus_index: int) -> float:
	var db_volume = AudioServer.get_bus_volume_db(bus_index)
	return db_to_linear(db_volume)

func _set_volume(bus_index: int, volume: float) -> void:
	AudioServer.set_bus_volume_linear(bus_index, volume)

func _on_master_volume_slider_value_changed(value: float) -> void:
	_set_volume(master_index, value)

func _on_music_volume_slider_value_changed(value: float) -> void:
	_set_volume(music_index, value)

func _on_sfx_volume_slider_value_changed(value: float) -> void:
	_set_volume(sfx_index, value)
