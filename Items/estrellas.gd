extends Node3D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	get_node("AnimationPlayer").play("Run")
