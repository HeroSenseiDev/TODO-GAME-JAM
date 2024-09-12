extends Node
var estoy_en_la_nave : bool = false
var Juegos_Terminado = {
	"Oxigeno": false,
	"Reactor": false,
	"Basura": false,
	"Nave": false,
}

var Tarea_Terminada = {
	"BateriaCargada": false,
	"BasuraRecogida": false,
	"TodoListo": false,
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
	pass

func _process(delta):
	# Verifica si todas las variables en BasuraEnSala son true
	if todas_las_basuras_recogidas():
		Tarea_Terminada["BasuraRecogida"] = true
	if all_tasks_completed():
		Tarea_Terminada["TodoListo"] = true

func todas_las_basuras_recogidas() -> bool:
	for value in BasuraEnSala.values():
		if not value:
			return false
	return true

func Relad_Game():
	#reset()
	get_tree().reload_current_scene()
	# Por ahora, así, si hay tiempo, se puede hacer una animación

func reset():
	for key in BasuraEnSala.keys():
		BasuraEnSala[key] = false
	for key in Juegos_Terminado.keys():
		Juegos_Terminado[key] = false
	for key in Tarea_Terminada.keys():
		Tarea_Terminada[key] = false
	estoy_en_la_nave = false

func all_tasks_completed() -> bool:
	for key in Juegos_Terminado.keys():
		if key != "Nave" and not Juegos_Terminado[key]:
			return false
	return true
