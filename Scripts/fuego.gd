extends Node3D
var player : Player
@onready var apagar: Area3D = $Fuego/Apagar

@onready var positions = {
	'P_1': $Positions/p_1.global_position,
	'P_2': $Positions/p_2.global_position,
	'P_3': $Positions/p_3.global_position,
	'P_4': $Positions/p_4.global_position,
	'P_5': $Positions/p_5.global_position,
}

@onready var fuego: Node3D = $Fuego
@onready var Particulas = [
	$Fuego/Particula_1, $Fuego/Particula_2, $Fuego/Particula_3
]
@onready var cambiar_fuego: Timer = $Cambiar_Fuego

@export var Limites_de_Fuegos: int = 5
var limites_de_fuegos: int
@export var Timer_to_reload: float = 3 
@export var Timer_Apagado: float = 3

var Apagado = 0
var Ramdon = RandomNumberGenerator.new()
var Fuego_Activo: bool
var Player_enter: bool

var Take_ultime_position = Vector3()

func _ready() -> void:
	player = get_tree().get_first_node_in_group("Player")
	randomize()
	cambiar_fuego.start(15)

func _process(delta: float) -> void:
	Apagado_de_fuego(delta)

func Apagado_de_fuego(delta):
	if Player_enter and Input.is_action_pressed("Take") and not player.is_carrying:
	
		Apagado -= delta
		player.fire_particles(false)
		if not Fuego_Activo:
			player.fire_particles(true)
	else:
		player.fire_particles(false)
	if not Fuego_Activo and not Apagado > 0:
		cambiar_fuego.start(Timer_to_reload)
		Off_On_Fuego(false)
		player.need_hold = false
		Fuego_Activo = true
		GameManager.gui.off_Alerta_Fuego()

func Off_On_Fuego(emitting: bool):
	for particula in Particulas:
		particula.emitting = emitting

func Cambiar_el_Fuego():
	for attempt in range(10):  # Limitar el número de intentos para evitar recursión infinita
		var how_1 = int(Ramdon.randf_range(1, 5))
		if positions.has('P_' + str(how_1)):
			if positions['P_' + str(how_1)] != Take_ultime_position:
				fuego.global_position = positions['P_' + str(how_1)]
				Take_ultime_position = fuego.global_position
				Off_On_Fuego(true)
				return
	print("No se pudo encontrar una posición válida después de 10 intentos")

func _on_cambiar_fuego_timeout() -> void:
	if limites_de_fuegos >= Limites_de_Fuegos:
		return
	Cambiar_el_Fuego()
	limites_de_fuegos += 1 
	Apagado = Timer_Apagado
	Fuego_Activo = false
	GameManager.gui.Alerta_Fuego()

func _on_apagar_area_entered(area: Area3D) -> void:
	if area.get_parent() is Player:
		Player_enter = true
		if not Fuego_Activo:
			player.need_hold = true

func _on_apagar_area_exited(area: Area3D) -> void:
	if area.get_parent() is Player:
		Player_enter = false
		player.need_hold = false
