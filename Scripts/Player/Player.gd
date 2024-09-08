extends CharacterBody3D
class_name Player

@export var speed : float = 15.0
var knockback_direction
@onready var carrying_offset: Node3D = $CarryingOffset
var can_take : bool
var carrying_object : Node3D
#Enter Mini Juego
var Enter_Mini_Juego:bool
var is_in_area : bool
#Animation Nodes
@onready var player_gfx: Node3D = $PlayerGFX
var is_carrying : bool
@export var offset : Vector2
var can_set : bool
@export var state_machine : StateMachine
@onready var battery_timer: Timer = $BatteryTimer
@onready var apagar_fuego: GPUParticles3D = $Apagar_Fuego
var need_hold : bool = false
func _ready() -> void:
	battery_timer.start()
	GameManager.player = self
	need_hold = false
func _process(delta: float) -> void:
	if not is_carrying:
		can_set = false
		
func _physics_process(delta: float) -> void:
	
	if is_carrying: 
		set_collision_mask_value(4, false)
	else:
		set_collision_mask_value(4, true)
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta
	move_and_slide()
	
func dead():
	pass
	
func fire_particles(on : bool):
	if on == true:
		apagar_fuego.emitting = true
	else :
		apagar_fuego.emitting = false


func _on_battery_timer_timeout() -> void:
	Transicion.call_Enter()
