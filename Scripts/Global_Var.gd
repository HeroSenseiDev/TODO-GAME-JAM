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
	get_tree().reload_current_scene()
	#POR A Hora Asi, sida Tiempo de puede hacer una animacion
