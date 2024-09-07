extends StaticBody3D

var player : Player
@export var destino : Node3D
@export var offset : Vector3
var cargaBateria
var is_charging : bool = false
var is_charged : bool = false
@onready var carrying_detection: CarryingDetect = $CarryingDetection

func _ready() -> void:
	# Al iniciar, obtenemos las referencias de la batería y el jugador
	cargaBateria = get_tree().get_first_node_in_group("CargaBateria")
	player = get_tree().get_first_node_in_group("Player")
	carrying_detection.CanCarrying.connect(player_is_in_area)
	carrying_detection.NotCanCarrying.connect(player_is_not_in_area)
	
func _process(delta: float) -> void:
	if player.carrying_object != self:
		set_collision_layer_value(1, true)
	var overlapping_bodies : Array[Node3D] = carrying_detection.get_overlapping_bodies()
	for body in overlapping_bodies:
		if body is Player:
			if GameManager.battery_is_charging == true:
				player.can_take = false
			elif GameManager.battery_is_charging == false and not player.is_carrying:
				player.can_take = true
			if player.can_take and Input.is_action_just_pressed("Take") and GameManager.battery_is_charging == false:
				reparent(player.carrying_offset)
				player.is_carrying = true
				player.can_take = false
				player.carrying_object = self
				set_collision_layer_value(1, false)
				global_position = player.carrying_offset.global_position
				global_rotation = player.carrying_offset.global_rotation
		
func player_is_in_area():
		player.is_in_area = true
		if GameManager.battery_is_charging == false and !player.is_carrying:
			player.can_take = true
func player_is_not_in_area():
	player.is_in_area = false
	player.can_take = false
