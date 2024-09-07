extends Node2D


@onready var Marcas = {
"Marca_1" : {
	"Marce": $Marca_1,
	"Rot":$Marca_1/Rot,
	"Raycas":$Marca_1/Rot/RayCast2D,
	"Select":$Marca_1/Select,
	"Active": false,
	"Push":$Marca_1/Push
},
"Marca_2" : {
	"Marce": $Marca_2,
	"Rot":$Marca_2/Rot,
	"Raycas":$Marca_2/Rot/RayCast2D,
	"Select":$Marca_2/Select,
	"Active": false,
	"Push":$Marca_2/Push
},
"Marca_3" : {
	"Marce": $Marca_3,
	"Rot":$Marca_3/Rot,
	"Raycas":$Marca_3/Rot/RayCast2D,
	"Select":$Marca_3/Select,
	"Active": false,
	"Push":$Marca_3/Push
}
}

@onready var label: Label = $Label
@onready var texture_progress_bar: TextureProgressBar = $Casula/Edit/TextureProgressBar
@onready var timer: Timer = $Timer

var how_select:int = 1
var how_select_active:int = 100
var turnos:int = 0 
var turnos_max:int = 3

var Value_:int 
var Run_Game:bool
var In_Game:bool
var Win_Dead:String
var Run_:bool 

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	GlobalVar.Juegos_Terminado["Oxigeno"] = false

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Run_Game and Run_ and turnos < 4:
		if not In_Game and Win_Dead != "WIN" or Win_Dead != "DEAD":
			In_Game = true
		Run(delta)
		
	Kill_or_Win()
	
func Run(delta):

	label_()

	var Select = Select()

	draw_select(Select)
	process_texture()
	push_select()
	

	if turnos < 4 and Input.is_action_just_pressed("Take"):
		if Set_is_collinding(Select) == false:
			reload_turno()
			turnos += 1
			

	#rotaticion
	for marca in Marcas.keys():
		if not Marcas[marca]["Active"]:
			Marcas[marca]["Rot"].rotation_degrees += (200 + how_select_active) * delta
			if Marcas[marca]["Rot"].rotation_degrees >= 360:
				Marcas[marca]["Rot"].rotation_degrees = 0
		else:
			if Marcas[marca]["Rot"].rotation_degrees <= 320:
				create_tween().tween_property(
				Marcas[marca]["Rot"], 
				"rotation_degrees", 0, 0.2) 
			else:
				create_tween().tween_property(
				Marcas[marca]["Rot"], 
				"rotation_degrees", 360, 0.2) 


func Select():
	how_select = 1
	#Para selecionar Las Marcas
	if Marcas["Marca_1"]["Active"]:
		how_select = 2
	if Marcas["Marca_2"]["Active"]:
		how_select = 3
	if Marcas["Marca_3"]["Active"]:
		how_select = 3

	var how_marca = str("Marca_") + str(how_select)

	if how_marca not in Marcas:
		return ""
	else:
		return how_marca
	

func label_():
	label.text = str(turnos) + str("/") + str(turnos_max)


func Set_is_collinding(how_select:String):

	Marcas[how_select]["Active"] = Marcas[how_select]["Raycas"].is_colliding()
	return Marcas[how_select]["Raycas"].is_colliding()

func draw_select(how_select_:String):

	#Color(0.302, 0.277, 0.202, 1)
	if how_select_ == "":
		return
	how_select = 1
	var take_Marca = Marcas[how_select_]
	var tween = create_tween()
	tween.tween_property(take_Marca["Select"], "color", Color.WHITE, 0.2) 

	for marca in Marcas.keys():
		if marca != how_select_:
			tween = create_tween()
			tween.tween_property(Marcas[marca]["Select"], "color", Color(0.302, 0.277, 0.202, 1), 0.2) 


func process_texture():
	
	if Marcas["Marca_1"]["Active"]:
		Value_ = 33
		how_select_active = 200

	if Marcas["Marca_2"]["Active"]:
		Value_ = 66
		how_select_active = 300

	if Marcas["Marca_3"]["Active"]:
		Value_ = 150
		how_select_active = 400
	
	if (
	Marcas["Marca_1"]["Active"] == false
	and Marcas["Marca_2"]["Active"] == false
	and Marcas["Marca_3"]["Active"] == false
	):
		Value_ = -20
		how_select_active = 0

	create_tween().tween_property(
	texture_progress_bar, 
	"value", Value_, 0.4)

func push_select():

	for marca in Marcas.keys():
		if Marcas[marca]["Raycas"].is_colliding():
			Marcas[marca]["Push"].color = Color(0.525, 0.757, 0)
		else:
			Marcas[marca]["Push"].color = Color(0, 0, 0, 0)

func reload_turno():

	for marca in Marcas.keys():

		Marcas[marca]["Active"] = false

		create_tween().tween_property(
		Marcas[marca]["Rot"], 
		"rotation_degrees", 90, 0.4) 

func Kill_or_Win():

	if turnos >= 3:
		Win_Dead = "DEAD"
		In_Game = false

	if (Marcas["Marca_1"]["Active"] 
	and Marcas["Marca_2"]["Active"] 
	and Marcas["Marca_3"]["Active"]):
		Win_Dead = "WIN"
		In_Game = false
		GlobalVar.Juegos_Terminado["Oxigeno"] = true
	

func _on_timer_timeout() -> void:
	Run_ = true
	turnos -= 1
