extends Node

var Juegos_Terminado = {
	"Oxigeno": false,
	"Reactor": false,
	"Basura": false
}

var Tarea_Terminada = {
	"BateriaCargada": false,
	"BasuraRecogida": false,
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

func _ready():
	# Aquí podrías inicializar cualquier configuración adicional si es necesario
	pass

func _process(delta):
	# Verifica si todas las variables en BasuraEnSala son true
	if todas_las_basuras_recogidas():
		Tarea_Terminada["BasuraRecogida"] = true

func todas_las_basuras_recogidas() -> bool:
	for value in BasuraEnSala.values():
		if not value:
			return false
	return true

func Relad_Game():
	reset()
	get_tree().reload_current_scene()
	# Por ahora, así, si hay tiempo, se puede hacer una animación

func reset():
	for key in BasuraEnSala.keys():
		BasuraEnSala[key] = false
	for key in Juegos_Terminado.keys():
		Juegos_Terminado[key] = false
	for key in Tarea_Terminada.keys():
		Tarea_Terminada[key] = false

func all_tasks_completed() -> bool:
	# Usa un bucle para verificar si todos los valores en Juegos_Terminado son true
	for value in Juegos_Terminado.values():
		if not value:
			return false
	return true
