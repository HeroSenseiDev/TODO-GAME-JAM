extends CharacterBody3D
class_name Player

@export var speed : float = 15.0
@onready var fray_cast: RayCast3D = $ForwardRayCast
@onready var anim: AnimationPlayer = $AnimationPlayer


func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta
	move_and_slide()
