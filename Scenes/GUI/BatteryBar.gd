extends TextureProgressBar
class_name BatteryBar

@export var player: Player

@onready var Baterias = [
	$"../Baterias/Bateria_1", 
	$"../Baterias/Bateria_2", 
	$"../Baterias/Bateria_3", 
	$"../Baterias/Bateria_4", 
	$"../Baterias/Bateria_5", 
	$"../Baterias/Bateria_6", 
	$"../Baterias/Bateria_7", 
	$"../Baterias/Bateria_8", 
	$"../Baterias/Bateria_9", 
	$"../Baterias/Bateria_10"
]

func _ready():
	if not player:
		player = get_tree().get_first_node_in_group("Player")
		max_value = player.battery_timer.wait_time * 1000
		value = max_value  # Iniciar con el valor máximo
func _process(delta):
	if GlobalVar.estoy_en_la_nave == true:
		$"../Baterias".visible = false
	else:
		$"../Baterias".visible = true
	# Calcular el valor actual basado en el tiempo transcurrido
	var time_passed = player.battery_timer.wait_time * 1000 - player.battery_timer.time_left * 1000
	value = max_value - time_passed
	#if value <= 0:
		#GlobalVar.Relad_Game()
	
	
	for i in range(10):

		var How_Value = ((i+1)*2000)
		
		if self.value >= How_Value:
			Baterias[i].region_rect.position.x = 0
		
		elif self.value >= How_Value/1.5:
			Baterias[i].region_rect.position.x = 16
			
		elif self.value >= How_Value/2:
			Baterias[i].region_rect.position.x = 32
		
		elif self.value <= How_Value:
			Baterias[i].region_rect.position.x = 48
		
		
	
