extends Node2D

@onready var nave_player: CharacterBody2D = $Nave_Player

const METRORITO = preload("res://Scenes2D/Nave/metrorito.tscn")

@onready var area_inputs_meteoritos: Area2D = $Area_Inputs_meteoritos
@onready var inputs_meteoritos: CollisionShape2D = $Area_Inputs_meteoritos/Inputs_meteoritos
@onready var set_meteorito: Timer = $Area_Inputs_meteoritos/Set_meteorito
var set_meteorito_:bool = false

var Ramdon = RandomNumberGenerator.new()

@onready var label: Label = $Label

@export var Limit_Time = 20 
var Real_Time = 0

var Run_Game:bool
var In_Game:bool
var Win_Dead:String

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	randomize()
	pass

func Set_Win(delta):
	
	Real_Time += delta
	label.text =  str(int(Real_Time)) + "/%s" % [Limit_Time]
	if Real_Time >= Limit_Time:
		nave_player.get_node("Kill My/CollisionShape2D").disabled = true
		In_Game = false
		Win_Dead = "WIN"
		print("Win")
		# Aqui se Puede llamar Una Animacino Para que el Sprite se desaparesca. 
		
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	
	if Run_Game:
		if not In_Game:
			In_Game = true
		Run(delta)
	
func Run(delta):
	
	Set_Win(delta)
	
	if not set_meteorito_:
		if Real_Time >= Limit_Time:
			set_meteorito.wait_time = 1
		else:
			set_meteorito.wait_time = 1 / (Real_Time / 4)
	else:
		Inputs_Meteoritos()
	
	if nave_player.Nave_Player_Dead:
		In_Game = false
		Win_Dead = "DEAD"
		print("DEAD")
		# Aqui se Puede llamar Una Animacino Para que el Sprite se desaparesca. 
		# Que se Prenda algo Algun lugar en Fuego.
	
func Inputs_Meteoritos():
	
	var size = inputs_meteoritos.shape.get("size")
	var Position = inputs_meteoritos.position
	var Min_Position_X = Position.x - (size.x/2)
	var Max_Position_X = Position.x + (size.x/2)
	var Position_x = Ramdon.randf_range(Min_Position_X, Max_Position_X)

	var I = METRORITO.instantiate()
	add_child(I)
	I.global_position = Vector2(Position_x, -size.y)
	if not Real_Time >= Limit_Time:
		I.Speed += Real_Time * 50
	else:
		if I.Speed > 200:
			I.Speed -= Real_Time * 50
	set_meteorito_ = false

func _on_set_meteorito_timeout() -> void:
	set_meteorito_ = true
