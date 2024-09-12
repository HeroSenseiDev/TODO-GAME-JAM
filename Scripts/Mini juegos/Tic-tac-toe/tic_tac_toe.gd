extends Node2D


@onready var Cuadrillas = {

'Casilla_1':{
	 'Position':$Cuadrillas/Casilla_1.global_position,
	 'Select':$Cuadrillas/Casilla_1/TextureRect2,
	 'Have':null,
	 'How':'',
	 'Rombo':$Cuadrillas/Casilla_1/Rombo,
	 'Circulo':$Cuadrillas/Casilla_1/Circulo,
},
'Casilla_2':{
	 'Position':$Cuadrillas/Casilla_2.global_position,
	 'Select':$Cuadrillas/Casilla_2/TextureRect2,
	 'Have':null,
	 'How':'',
	 'Rombo':$Cuadrillas/Casilla_2/Rombo,
	 'Circulo':$Cuadrillas/Casilla_2/Circulo,
},
'Casilla_3':{
	 'Position':$Cuadrillas/Casilla_3.global_position,
	 'Select':$Cuadrillas/Casilla_3/TextureRect2,
	 'Have':null,
	 'How':'',
	 'Rombo':$Cuadrillas/Casilla_3/Rombo,
	 'Circulo':$Cuadrillas/Casilla_3/Circulo,
},
'Casilla_4':{
	 'Position':$Cuadrillas/Casilla_4.global_position,
	 'Select':$Cuadrillas/Casilla_4/TextureRect2,
	 'Have':null,
	 'How':'',
	 'Rombo':$Cuadrillas/Casilla_4/Rombo,
	 'Circulo':$Cuadrillas/Casilla_4/Circulo,
},
'Casilla_5':{
	 'Position':$Cuadrillas/Casilla_5.global_position,
	 'Select':$Cuadrillas/Casilla_5/TextureRect2,
	 'Have':null,
	 'How':'',
	 'Rombo':$Cuadrillas/Casilla_5/Rombo,
	 'Circulo':$Cuadrillas/Casilla_5/Circulo,
},
'Casilla_6':{
	 'Position':$Cuadrillas/Casilla_6.global_position,
	 'Select':$Cuadrillas/Casilla_6/TextureRect2,
	 'Have':null,
	 'How':'',
	 'Rombo':$Cuadrillas/Casilla_6/Rombo,
	 'Circulo':$Cuadrillas/Casilla_6/Circulo,
},
'Casilla_7':{
	 'Position':$Cuadrillas/Casilla_7.global_position,
	 'Select':$Cuadrillas/Casilla_7/TextureRect2,
	 'Have':null,
	 'How':'',
	 'Rombo':$Cuadrillas/Casilla_7/Rombo,
	 'Circulo':$Cuadrillas/Casilla_7/Circulo,
},
'Casilla_8':{
	 'Position':$Cuadrillas/Casilla_8.global_position,
	 'Select':$Cuadrillas/Casilla_8/TextureRect2,
	 'Have':null,
	 'How':'',
	 'Rombo':$Cuadrillas/Casilla_8/Rombo,
	 'Circulo':$Cuadrillas/Casilla_8/Circulo,
},
'Casilla_9':{
	 'Position':$Cuadrillas/Casilla_9.global_position,
	 'Select':$Cuadrillas/Casilla_9/TextureRect2,
	 'Have':null,
	 'How':'',
	 'Rombo':$Cuadrillas/Casilla_9/Rombo,
	 'Circulo':$Cuadrillas/Casilla_9/Circulo,
},
}

@onready var Lineas = {
	"Vertical_UP": {
		"Node": $Lineas/Vertical_UP,
		"Min_Position": $Lineas/Vertical_UP.points[0],
		"Max_Position": $Lineas/Vertical_UP.points[1],
	},
	"Vertical_MED": {
		"Node": $Lineas/Vertical_MED,
		"Min_Position": $Lineas/Vertical_MED.points[0],
		"Max_Position": $Lineas/Vertical_MED.points[1],
	},
	"Vertical_DOWN": {
		"Node": $Lineas/Vertical_DOWN,
		"Min_Position": $Lineas/Vertical_DOWN.points[0],
		"Max_Position": $Lineas/Vertical_DOWN.points[1],
	},
	"Horizontal_LEFT": {
		"Node": $Lineas/Horizontal_LEFT,
		"Min_Position": $Lineas/Horizontal_LEFT.points[0],
		"Max_Position": $Lineas/Horizontal_LEFT.points[1],
	},
	"Horizontal_MED": {
		"Node": $Lineas/Horizontal_MED,
		"Min_Position": $Lineas/Horizontal_MED.points[0],
		"Max_Position": $Lineas/Horizontal_MED.points[1],
	},
	"Horizontal_RIGHT": {
		"Node": $Lineas/Horizontal_RIGHT,
		"Min_Position": $Lineas/Horizontal_RIGHT.points[0],
		"Max_Position": $Lineas/Horizontal_RIGHT.points[1],
	},
	"Diagonal_LEFT": {
		"Node": $Lineas/Diagonal_LEFT,
		"Min_Position": $Lineas/Diagonal_LEFT.points[0],
		"Max_Position": $Lineas/Diagonal_LEFT.points[1],
	},
	"Diagonal_RIGHT": {
		"Node": $Lineas/Diagonal_RIGHT,
		"Min_Position": $Lineas/Diagonal_RIGHT.points[0],
		"Max_Position": $Lineas/Diagonal_RIGHT.points[1],
	}
}


@onready var ia_game: Timer = $IA_Game


@export var Color_: Color

var Ramdon = RandomNumberGenerator.new()

var Direction = Vector2(1,1)
var IA_IN_GAME:bool = true
var Ia_Time:bool = false

var turnos = 0
var turnos_max = 3

var Empate = false
var Run_Game:bool
var In_Game:bool
var Win_Dead:String
var Run_:bool 

var timer_run:float

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	randomize()

func _process(delta: float) -> void:
	
	if timer_run <= 3:
		timer_run += delta

	if Run_Game and timer_run >= 3:
		if not In_Game and Win_Dead != "WIN" or Win_Dead != "DEAD":
			In_Game = true
		Run(delta)
	#if Win_Dead == "WIN": GlobalVar.Juegos_Terminado["Basura"] = true
	Kill_or_Win("Win")
	Kill_or_Win("Dead")

func Select_casilla():
	
	if Input.is_action_just_pressed("ui_left"):
		Direction.x -= 1 if not Direction.x <= 1 else 0
	if Input.is_action_just_pressed("ui_right"):
		Direction.x += 1 if not Direction.x >= 3 else 0
	if Input.is_action_just_pressed("ui_up"):
		Direction.y -= 1 if not Direction.y <= 1 else 0
	if Input.is_action_just_pressed("ui_down"):
		Direction.y += 1 if not Direction.y >= 3 else 0

	var Position:float
	if Direction.y == 1:
		Position = Direction.x
	if Direction.y == 2:
		Position = Direction.x + 3
	if Direction.y == 3:
		Position = Direction.x + 6
	return str("Casilla_") + str(Position)


func draw_select_casilla(how_casilla:String):
	for casilla in Cuadrillas.keys():
		if casilla != how_casilla:
			create_tween().tween_property(Cuadrillas[casilla]["Select"], "modulate", Color_ , 0.2)
	create_tween().tween_property(Cuadrillas[how_casilla]["Select"], "modulate", Color.WHITE, 0.2)
	
func Add_Object(how):
	if not how:
		return
	how.scale = Vector2(0, 0)
	how.visible = true
	create_tween().tween_property(how, "scale", Vector2(1, 1), 0.2)
	create_tween().tween_property(how, "scale", Vector2(1.2, 1.2), 0.1).set_delay(0.2)
	create_tween().tween_property(how, "scale", Vector2(1, 1), 0.05).set_delay(0.3)

func Player_set_Object(how_casilla:String):

	if IA_IN_GAME and Input.is_action_just_pressed("Take"):
		if Cuadrillas[how_casilla]["Have"] == null:
			Add_Object(Cuadrillas[how_casilla]["Circulo"])
			Cuadrillas[how_casilla]["Have"] = true
			Cuadrillas[how_casilla]["How"] = "Circulo"
			IA_IN_GAME = false
			ia_game.start(0.5)

func Select_casilla_to_Ia():
	return str("Casilla_") + str(int(Ramdon.randf_range(int(1), int(10))))


func IA_set_Object():

	if IA_IN_GAME == false and Ia_Time:
		var cual = Select_casilla_to_Ia()
		if Cuadrillas[cual]["Have"] == null:
			Add_Object(Cuadrillas[cual]["Rombo"])
			Cuadrillas[cual]["Have"] = true
			Cuadrillas[cual]["How"] = "Rombo"
			IA_IN_GAME = true
			Ia_Time = false
		else:
			cual = Select_casilla_to_Ia()


func Add_Linea(how_linea:String):

	Lineas[how_linea]["Node"].visible = true
	Lineas[how_linea]["Node"].modulate = Color(1, 1, 1, 0)
	create_tween().tween_property(Lineas[how_linea]["Node"], "modulate", Color.WHITE, 0.5)



func Run(delta):
	var Casilla_Activa = Select_casilla()
	draw_select_casilla(Casilla_Activa)
	Player_set_Object(Casilla_Activa)
	IA_set_Object()
	#Reload_turno()
	

func Reload_turno():
	for casilla in Cuadrillas.keys():
		if Cuadrillas[casilla]["Have"] == null:
			return

	

	for casilla in Cuadrillas.keys():
		Cuadrillas[casilla]["Rombo"].visible = false
		Cuadrillas[casilla]["Circulo"].visible = false
		IA_IN_GAME = false
		turnos += 1 

func set_Lineas(how_casillas:Array, how_linea:String, object_tipe:String):

	
	# Esto mira si La linea es La Adecuada. 
	if (
	Cuadrillas[how_casillas[0]]["How"] == "" or not Cuadrillas[how_casillas[0]]["How"] == object_tipe or
	Cuadrillas[how_casillas[1]]["How"] == "" or not Cuadrillas[how_casillas[1]]["How"] == object_tipe or
	Cuadrillas[how_casillas[2]]["How"] == "" or not Cuadrillas[how_casillas[2]]["How"] == object_tipe or
	not Cuadrillas[how_casillas[0]]["How"] == Cuadrillas[how_casillas[1]]["How"] or 
	not Cuadrillas[how_casillas[1]]["How"] == Cuadrillas[how_casillas[2]]["How"]
	):
		Empate = false
		return false

	# Esto Dibuja Las Lineas.
	Lineas[how_linea]["Node"].visible = true
	Lineas[how_linea]["Node"].modulate = Color(1, 1, 1, 0)
	create_tween().tween_property(Lineas[how_linea]["Node"], "modulate", Color.WHITE, 0.5)
	Empate = true
	return true
	
	
func Kill_or_Win(how:String):



	# Mira que Linea Va a dibujar
	var type = "Circulo" if how == "Win" else "Rombo"


	if set_Lineas(["Casilla_1", "Casilla_2", "Casilla_3"], "Vertical_UP", type):
		Win_Dead = "WIN" if how == "Win" else "DEAD"
		In_Game = false
		return
		
	if set_Lineas(["Casilla_4", "Casilla_5", "Casilla_6"], "Vertical_MED", type):
		Win_Dead = "WIN" if how == "Win" else "DEAD"
		In_Game = false
		return
		
	if set_Lineas(["Casilla_7", "Casilla_8", "Casilla_9"], "Vertical_DOWN", type):
		Win_Dead = "WIN" if how == "Win" else "DEAD"
		In_Game = false
		return
		
	if set_Lineas(["Casilla_1", "Casilla_4", "Casilla_7"], "Horizontal_LEFT", type):
		Win_Dead = "WIN" if how == "Win" else "DEAD"
		In_Game = false
		return

	if set_Lineas(["Casilla_2", "Casilla_5", "Casilla_8"], "Horizontal_MED", type):
		Win_Dead = "WIN" if how == "Win" else "DEAD"
		In_Game = false
		return
		
	if set_Lineas(["Casilla_3", "Casilla_6", "Casilla_9"], "Horizontal_RIGHT", type):
		Win_Dead = "WIN" if how == "Win" else "DEAD"
		In_Game = false
		return
		
	if set_Lineas(["Casilla_1", "Casilla_5", "Casilla_9"], "Diagonal_LEFT", type):
		Win_Dead = "WIN" if how == "Win" else "DEAD"
		In_Game = false
		return
		
	if set_Lineas(["Casilla_3", "Casilla_5", "Casilla_7"], "Diagonal_RIGHT", type):
		Win_Dead = "WIN" if how == "Win" else "DEAD"
		In_Game = false
		return
		
	for casilla in Cuadrillas.keys():
		if not Cuadrillas[casilla]["How"] != "" or Win_Dead == "WIN":
			return

	if Empate == false:
		Win_Dead = "DEAD"
		In_Game = false

	
	

func _on_ia_game_timeout() -> void:
	Ia_Time = true
