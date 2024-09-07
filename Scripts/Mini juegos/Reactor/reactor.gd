extends Node2D


@onready var Input_ = {
	"Position":$Input/Edit_Position,
	"Progress": $Input/Edit_Position/Progress,
	"collesion": $Input/Edit_Position/Enter/CollisionShape2D,
	"Live": $Input/Edit_Position/Live,
}


@onready var Output_ = {
	"Position":$Output/Edit_Position,
	"Visible": $Output/Edit_Position/VisibleOnScreenEnabler2D
}
@onready var label: Label = $Label
@onready var set_position: Timer = $Set_Position
@onready var timer: Timer = $Timer


var how_Position_x:float
var how_Position_x_min:float
var how_position = Vector2()
var Power:float
var Power_max:float = 700

var Is_colliding:bool
var turnos = 0
var turnos_max = 3

var Ramdon = RandomNumberGenerator.new()

var player : Player
var Run_Game:bool
var In_Game:bool
var Win_Dead:String
var Run_:bool 

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	player = get_tree().get_first_node_in_group("Player")
	GlobalVar.Juegos_Terminado["Reactor"] = false
	randomize()
	set_position.start(1)
	how_position = Vector2(how_Position_x_min, Ramdon.randf_range(69, 664))

	how_Position_x = Input_["Position"].global_position.x
	how_Position_x_min = Input_["Position"].global_position.x


	Output_["Visible"].connect("screen_exited", Callable(self, "In_Screen_exited"))

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Run_Game and Run_ and turnos < 4:
		if not In_Game and Win_Dead != "WIN" or Win_Dead != "DEAD":
			In_Game = true
		Run(delta)
	Kill_or_Win()

func Run(delta):
	set_position_to_Input(delta)
	set_postion_to_output(delta)
	label_()



func set_position_to_Input(delta):

	if Is_colliding == true:
		create_tween().tween_property(Input_["Progress"], "modulate", Color(1, 1, 1 ,0), 0.2)
		return

	if Input.is_action_pressed("Take"):
		if Power <= Power_max:
			Power += 500 * delta

	if how_Position_x <= how_Position_x_min and Input.is_action_just_released("Take"):
		how_Position_x += Power * 1.2
		turnos += 1 
		Power = 0 
		Input_["collesion"].disabled = false
		Input_["Live"].start(0.3)


	if how_Position_x >= how_Position_x_min:
		how_Position_x -= 1200 * delta


	how_position = Vector2(how_Position_x, how_position.y)
	create_tween().tween_property(Input_["Position"], "global_position", how_position, 0.3)

	Input_["Progress"].value = Power / 7

func set_postion_to_output(delta):
	if Is_colliding == true:
		return
	Output_["Position"].global_position.y += 400 * (turnos+2/2) * delta
	

func In_Screen_exited():
	if Is_colliding == false:
		Output_["Position"].global_position.y = -80
		Output_["Position"].global_position.x = Ramdon.randf_range(300, 700)
	

func label_():
	label.text = str(turnos) + str("/") + str(turnos_max)


func Kill_or_Win():
	

	if turnos >= 3 and Is_colliding == false:
		if not how_Position_x <= how_Position_x_min:
			return
		Win_Dead = "DEAD"
		In_Game = false

	if Is_colliding == true:
		
		Win_Dead = "WIN"
		In_Game = false
		GlobalVar.Juegos_Terminado["Reactor"] = true
		player.can_set = false

func _on_set_position_timeout() -> void:
	if Is_colliding == true:
		return
	set_position.start(1 - turnos/2)
	how_position = Vector2(how_Position_x, Ramdon.randf_range(69, 664))


func _on_enter_area_entered(area: Area2D) -> void:
	Is_colliding = true
	create_tween().tween_property(
		Input_["Position"], "global_position", Output_["Position"].global_position, 0.3)


func _on_live_timeout() -> void:
	Input_["collesion"].disabled = true


func _on_timer_timeout() -> void:
	Run_ = true
	turnos -= 1 
