extends Node3D


@export var Mini_Juego: PackedScene
var Mini_Juego_node
@onready var take: SubViewport = $Take
@onready var animation_player: AnimationPlayer = $AnimationPlayer

var player
var Player_Enter:bool


func _ready() -> void:
	Set_Game()
	animation_player.play("RESET")
	player = get_tree().get_first_node_in_group("Player")
	
	
func Set_Game():
	if Mini_Juego:
		var i = Mini_Juego.instantiate()
		take.add_child(i)
		Mini_Juego_node = i

func _process(delta: float) -> void:
	if not Mini_Juego_node:
		return
	
	if Player_Enter and not Mini_Juego_node.In_Game:
		if Input.is_action_just_pressed("Take"):
			Mini_Juego_node.Run_Game = true
			player.state_machine.change_to("PlayerGameState")
			animation_player.play("enter")
	
	if Mini_Juego_node.Win_Dead == "WIN" or Mini_Juego_node.Win_Dead == "DEAD":
		if not Mini_Juego_node.In_Game:
			player.state_machine.change_to("PlayerGroundState")
			animation_player.play("close")

func _on_player_enter_area_entered(area: Area3D) -> void:
	Player_Enter = true


func _on_player_enter_area_exited(area: Area3D) -> void:
	Player_Enter = false
