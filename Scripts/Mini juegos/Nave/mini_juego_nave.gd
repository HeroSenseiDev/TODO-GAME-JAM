extends Node2D

@onready var nave_player: CharacterBody2D = $Nave_Player

const METRORITO = preload("res://Scenes2D/Nave/metrorito.tscn")

@onready var area_inputs_meteoritos: Area2D = $Area_Inputs_meteoritos
@onready var inputs_meteoritos: CollisionShape2D = $Area_Inputs_meteoritos/Inputs_meteoritos
@onready var set_meteorito: Timer = $Area_Inputs_meteoritos/Set_meteorito
@onready var redy: Timer = $Redy

var set_meteorito_:bool = false

var Ramdon = RandomNumberGenerator.new()

@onready var label: Label = $Label

@export var Limit_Time = 20 
var Real_Time = 0

var Run_Game:bool
var In_Game:bool
var Win_Dead:String

var is_ready:bool = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	randomize()
	

func Set_Win_Dead(delta):
	
	
	label.text =  str(int(Real_Time)) + "/%s" % [Limit_Time]
	if Real_Time >= Limit_Time:
		In_Game = false
		Win_Dead = "WIN"
		GlobalVar.Juegos_Terminado["Nave"] = true
		# Aqui se Puede llamar Una Animacino Para que el Sprite se desaparesca. 
		
	if nave_player.Nave_Player_Dead:
		In_Game = false
		Win_Dead = "DEAD"
		GlobalVar.Relad_Game()
		# Aqui se Puede llamar Una Animacino Para que el Sprite se desaparesca. 
		# Que se Prenda algo Algun lugar en Fuego.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	
	if Run_Game:
		
		if not In_Game and Win_Dead != "WIN" or Win_Dead != "DEAD":
			In_Game = true
		Run(delta)
	else:
		set_meteorito.start(1)

func Run(delta):
	
	Set_Win_Dead(delta)

	if not nave_player.Nave_Player_Dead:
		Real_Time += delta
	
func Inputs_Meteoritos():

	var size = inputs_meteoritos.shape.get("size")
	var Position = inputs_meteoritos.position
	var Min_Position_X = Position.x - (size.x/2)
	var Max_Position_X = Position.x + (size.x/2)
	var Position_x = Ramdon.randf_range(Min_Position_X, Max_Position_X)

	var I = METRORITO.instantiate()
	add_child(I)
	var how_position = Ramdon.randf_range(1, 2)
	I.global_position = Vector2(nave_player.global_position.x if how_position == 1 else Position_x, -size.y)
	if not Real_Time >= Limit_Time:
		I.Speed += Real_Time * 50
	else:
		if I.Speed > 200:
			I.Speed -= Real_Time * 50
	
		
func _on_set_meteorito_timeout() -> void:
	if Run_Game == false:
		return
	Inputs_Meteoritos()
	if Real_Time > 15 :
		set_meteorito.start(0.2)
	elif Real_Time > 10 :
		set_meteorito.start(0.3)
	else:	
		set_meteorito.start(0.6)
