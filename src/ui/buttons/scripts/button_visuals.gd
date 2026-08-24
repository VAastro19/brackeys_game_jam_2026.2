# button_visuals.gd
extends BaseButton

var tween: Tween
var normal_scale: Vector2 = scale
var big_scale: Vector2 = scale * 1.05
var small_scale: Vector2 = scale * 0.95

func _ready() -> void:
	mouse_entered.connect(_on_mouse_entered)
	mouse_exited.connect(_on_mouse_exited)
	pressed.connect(_on_pressed)
	
	pivot_offset_ratio = Vector2(0.5, 0.5)

func _on_mouse_entered() -> void:
	if tween: tween.kill()
	scale = big_scale

func _on_mouse_exited() -> void:
	if tween: tween.kill()
	scale = normal_scale

func _on_pressed() -> void:
	tween = create_tween().set_ease(Tween.EASE_OUT_IN).set_trans(Tween.TRANS_SINE)
	tween.tween_property(self, "scale", small_scale, 0.05)
	tween.tween_property(self, "scale", big_scale, 0.05)
