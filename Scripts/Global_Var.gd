extends Node


var Juegos_Terminado = {
	"Nave": false,
	"Oxigeno": false,
	"Reactor": false, 
}

var Tarea_Terminada = {
	"BateriaCargada": false,
}

var BasuraEnSala = {
	"Trash1": false,
	"Trash2": false,
	"Trash3": false,
	#"Trash4": false,
	"Trash5": false,
	"Trash6": false,
	"Trash7": false,
	"Trash8": false,
	"Trash9": false,
}



func Relad_Game():
	reset()
	get_tree().reload_current_scene()
	#POR A Hora Asi, sida Tiempo de puede hacer una animacion
	
func reset():
	for keys in BasuraEnSala.keys():
		BasuraEnSala[keys] = false
	for keys in Juegos_Terminado.keys():
		Juegos_Terminado[keys] = false
	for keys in Tarea_Terminada.keys():
		Tarea_Terminada[keys] = false
		
func all_tasks_completed():
	# Usa un bucle para verificar si todos los valores son true
	for key in Juegos_Terminado.keys():
		if not Juegos_Terminado[key]:
			return false
	return true
