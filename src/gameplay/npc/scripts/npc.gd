# npc.gd
class_name NPC extends Entity

@export var npc_type: Enums.NPCType
@export var is_merchant: bool = false
@export var is_seller: bool = false


@onready var interaction_zone: Area2D = $InteractionZone

var player_in_range: bool = false

func _ready() -> void:
	interaction_zone.body_entered.connect(_on_body_entered)
	interaction_zone.body_exited.connect(_on_body_exited)

func _input(event: InputEvent) -> void:
	if player_in_range:
		if event.is_action_pressed("interact"):
			EventBus.OnNPCInteracted.emit(self)

func _on_body_entered(body: Node2D) -> void:
	if body is Player:
		player_in_range = true
		EventBus.OnNPCClose.emit(self)

func _on_body_exited(body: Node2D) -> void:
	if body is Player:
		player_in_range = false
		EventBus.OnNPCFar.emit()
