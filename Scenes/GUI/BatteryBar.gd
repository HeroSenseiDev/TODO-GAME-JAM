extends TextureProgressBar
class_name BatteryBar

@export var player: Player

func _ready():
	if not player:
		player = get_tree().get_first_node_in_group("Player")
		max_value = player.battery_timer.wait_time * 1000
		value = max_value  # Iniciar con el valor máximo
func _process(delta):
	# Calcular el valor actual basado en el tiempo transcurrido
	var time_passed = player.battery_timer.wait_time * 1000 - player.battery_timer.time_left * 1000
	value = max_value - time_passed
