extends Control
class_name GUI
@onready var set_label: MarginContainer = $E2Set
@onready var label: Label = $E2Set/Label
@export var health_bar : HealthPlayerBar
@export var player : Player
@onready var interact_label: MarginContainer = $E2Interact

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	GameManager.gui = self
	if not player:
		player = get_tree().get_first_node_in_group("Player")
		
	health_bar.battery_component = player.battery_component
	health_bar.on_ready()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
