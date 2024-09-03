extends CharacterBody3D
class_name Player

@export var speed : float = 15.0
var knockback_direction
@onready var carrying_offset: Node3D = $CarryingOffset

#Animation Nodes
@onready var player_gfx: Node3D = $PlayerGFX


func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta
	move_and_slide()
