extends StaticBody3D


var player : Player
@export var destino : Node3D
@export var offset : Vector3

@onready var carrying_detection: CarryingDetect = $Detection

func _ready() -> void:
	# Al iniciar, obtenemos las referencias de la batería y el jugador
	player = get_tree().get_first_node_in_group("Player")
	carrying_detection.CanCarrying.connect(player_is_in_area)
	carrying_detection.NotCanCarrying.connect(player_is_not_in_area)
	
func _process(delta: float) -> void:
	if player.is_in_area:
		if player.can_take and Input.is_action_just_pressed("Take"):
			reparent(player.carrying_offset)
			player.is_carrying = true
			global_position =player.carrying_offset.global_position + offset
			global_rotation = player.carrying_offset.global_rotation
			player.can_take = false
		
func player_is_in_area():
		player.is_in_area = true
		player.can_take = true
func player_is_not_in_area():
	player.is_in_area = false
	player.can_take = false
