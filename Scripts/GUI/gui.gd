extends Control
class_name GUI
@onready var set_label: MarginContainer = $E2Set
@onready var label: Label = $E2Set/Label
@export var player : Player
@onready var interact_label: MarginContainer = $E2Interact
@onready var label_time: RichTextLabel = $MarginContainer2/HBoxContainer/Label_Time
@onready var sub_label_time: RichTextLabel = $MarginContainer2/HBoxContainer/subLabel_Time
@onready var hold: MarginContainer = $Hold


@onready var alerta_fuego: AnimationPlayer = $Alerta_Fuego/Alerta_Fuego
@onready var sub_label_fire: RichTextLabel = $Alerta_Fuego/Control/subLabel_fire

var Alert_fuego:bool
var Time_to_dead_for_fire:float = 20
var Time_to_dead:float = 90
var Time_to_Control : float = 7   


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	GameManager.gui = self
	if not player:
		player = get_tree().get_first_node_in_group("Player")
	hold.visible = false


func Timer_Dead(delta):

	Time_to_dead -= delta
	label_time.text = str(int(Time_to_dead)) + "S"

	var how_color = "[color=cyan]"
	if Time_to_dead < 20:
		how_color = "[color=red]"
	elif Time_to_dead < 60:
		how_color = "[color=yellow]"

	sub_label_time.text =  how_color + "[shake rate=20.0 level=5 connected=1]For meteorites[/shake]"
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	Timer_Dead(delta)
	Timer_Fire(delta)
	if Input.is_action_just_pressed("Esc"):
		Transicion.Enter_Scena = "res://Menus/enter_menu.tscn"
		Transicion.call_Enter()

func Timer_Fire(delta):
	if Alert_fuego == true:
		var level:int = 10
		Time_to_dead_for_fire -= delta
		if Time_to_dead_for_fire > 15:
			level = 3
		if Time_to_dead_for_fire <= 15:
			level = 5
		if Time_to_dead_for_fire <= 10:
			level = 8
		if Time_to_dead_for_fire <= 5:
			level = 15
		if Time_to_dead_for_fire <= 0:
			Transicion.call_Enter()
			
		sub_label_fire.text = str(int(Time_to_dead_for_fire)) + "[shake rate=20.0 level="+str(level)+"connected=1]Time to extinguish the fire![/shake]"
		
		#if Time_to_dead_for_fire < 0:
			#QUE QUE ESPLOTE lA NAVE
		
func Alerta_Fuego():
	Alert_fuego = true
	alerta_fuego.play("Alerta_Fuego")
	create_tween().tween_property(sub_label_fire, "modulate", Color(0.741, 0, 0.157), 0.2)
func off_Alerta_Fuego():
	Alert_fuego = false
	alerta_fuego.play("RESET")
	Time_to_dead_for_fire = 20
	create_tween().tween_property(sub_label_fire, "modulate", Color(0.741, 0, 0.157, 0.0), 0.2)
