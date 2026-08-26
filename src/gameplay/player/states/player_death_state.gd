# player_death_state.gd
extends State

func enter_state(entity_node) -> void:
	super(entity_node)
	entity.velocity = Vector2.ZERO
	entity.is_dead = true
	
	entity.sprite.animation_finished.connect(_on_animation_finished)
	entity.sprite.play("death")

func _on_animation_finished() -> void:
	var tween = create_tween()
	tween.tween_property(entity, "modulate:a", 0, 1)
	await tween.finished
	
	entity.sprite.animation_finished.disconnect(_on_animation_finished)
	entity.respawn()
