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

var meteorito_interval = 1.0
var last_meteorito_time = 0.0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	randomize()
	set_meteorito.autostart = true

func Set_Win(delta):
	Real_Time += delta
	label.text = str(int(Real_Time)) + "/%s" % [Limit_Time]
	if Real_Time >= Limit_Time:
		In_Game = false
		Win_Dead = "WIN"
		Transicion.Enter_Scena = "res://Win/win.tscn"
		Transicion.how_set = "CHANGE_SCENE"
		Transicion.call_Enter()
		GlobalVar.Juegos_Terminado["Nave"] = true
		# Restablecer Real_Time al ganar
		Real_Time = 0 
		
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Run_Game:
		if not In_Game and Win_Dead != "WIN" and Win_Dead != "DEAD":
			In_Game = true
			GlobalVar.estoy_en_la_nave = true
		Run(delta)

func Run(delta):
	Set_Win(delta)

	if not set_meteorito_:
		var wait_time = max(0.01, 1 - (Real_Time * 2.3 * delta))
		set_meteorito.wait_time = wait_time
	else:
		Inputs_Meteoritos()
	
	if nave_player.Nave_Player_Dead:
		In_Game = false
		Win_Dead = "DEAD"
		# Restablecer Real_Time al perder
		Real_Time = 0 
		Transicion.call_Enter()

func Inputs_Meteoritos():
	var current_time = Time.get_ticks_usec() / 1000
	if current_time - last_meteorito_time >= meteorito_interval * 1000 / pow(1 + (Real_Time / Limit_Time), 2):
		last_meteorito_time = current_time
		
		var size = inputs_meteoritos.shape.get("size")
		var Position = inputs_meteoritos.position
		var Min_Position_X = Position.x - (size.x / 2)
		var Max_Position_X = Position.x + (size.x / 2)
		
		# Genera una posición aleatoria en el eje X
		var Position_x = Ramdon.randf_range(Min_Position_X, Max_Position_X)
		
		# Genera una posición aleatoria en el eje Y
		var Position_y = Ramdon.randf_range(-size.y, 0)
		
		var I = METRORITO.instantiate()
		add_child(I)
		var how_position = Ramdon.randf_range(1, 2)
		I.global_position = Vector2(nave_player.global_position.x if how_position == 1 else Position_x, Position_y)
		I.Speed += (Real_Time / Limit_Time) * 1000
		I.Speed = clamp(I.Speed, 0, 1000)
		
	set_meteorito_ = false
	
func _on_set_meteorito_timeout() -> void:
	set_meteorito_ = true
