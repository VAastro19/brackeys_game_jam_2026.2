# are_you_sure_box.gd
extends NinePatchRect

@export_multiline var box_text: String = "Are you sure you want to quit?"

@onready var label: Label = $Label

func _ready() -> void:
	label.text = box_text
