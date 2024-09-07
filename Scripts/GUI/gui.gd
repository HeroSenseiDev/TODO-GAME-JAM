extends Control
class_name GUI
@onready var set_label: MarginContainer = $E2Set
@onready var label: Label = $E2Set/Label
@export var health_bar : HealthPlayerBar
@export var player : Player
@onready var interact_label: MarginContainer = $E2Interact
@onready var label_time: RichTextLabel = $MarginContainer2/HBoxContainer/Label_Time
@onready var sub_label_time: RichTextLabel = $MarginContainer2/HBoxContainer/subLabel_Time


var Time_to_dead:float = 90   


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass
	#GameManager.gui = self
	#if not player:
	#	player = get_tree().get_first_node_in_group("Player")
	#	
	#health_bar.battery_component = player.battery_component
	#health_bar.on_ready()


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
	
	
	if Input.is_action_just_pressed("Esc"):
		Transicion.Enter_Scena = "res://Menus/enter_menu.tscn"
		Transicion.call_Enter()
