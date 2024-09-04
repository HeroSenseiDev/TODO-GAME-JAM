extends CharacterBody3D
class_name Player

@export var speed : float = 15.0
var knockback_direction
@onready var carrying_offset: Node3D = $CarryingOffset
var can_take : bool
var object : Node3D
#Animation Nodes
@onready var player_gfx: Node3D = $PlayerGFX
var is_carrying : bool
@export var offset : Vector2

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta
	move_and_slide()
