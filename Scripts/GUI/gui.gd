extends Control
class_name GUI

@onready var interact_label: MarginContainer = $E2Interact

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	GameManager.gui = self


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
