extends MeshInstance3D
@onready var cargador: Destiny = $Cargador
@onready var charging_time: Timer = $ChargingTime
@onready var bateria_cargada: StaticBody3D = $BateriaCargada
var player : Player

func _ready() -> void:
	player = get_tree().get_first_node_in_group("Player")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func start_charge():
	charging_time.start()
	


func _on_charging_time_timeout() -> void:
	if !player.is_carrying:
		bateria_cargada.global_position = $PosicionBateriaCargada.global_position
		charging_time.stop()


func _on_cargador_object_in_destiny() -> void:
	if charging_time.is_stopped():
		start_charge()
