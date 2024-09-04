extends Node3D


@export var Mini_Juego: Node2D
@onready var take: SubViewport = $Take
@onready var animation_player: AnimationPlayer = $AnimationPlayer

var Player_Enter:bool
var player : Player

var Run_Game:bool



# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	player = get_tree().get_first_node_in_group("Player")
	Set_Game()
	animation_player.play("RESET")
	
func Set_Game():
	if Mini_Juego:
		take.add_child(Mini_Juego)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Player_Enter and not Mini_Juego.In_Game:
		if Input.is_action_just_pressed("Take"):
			Mini_Juego.Run_Game = true
			player.state_machine.change_to("PlayerGameState")
			animation_player.play("enter")
	
	if Mini_Juego.Win_Dead == "WIN" or Mini_Juego.Win_Dead == "DEAD":
		animation_player.play("close")

func _on_player_enter_area_entered(area: Area3D) -> void:
	Player_Enter = true


func _on_player_enter_area_exited(area: Area3D) -> void:
	Player_Enter = false
