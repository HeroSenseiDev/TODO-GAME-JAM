extends Node3D


@export var Mini_Juego: PackedScene
var Mini_Juego_node
@onready var take: SubViewport = $Take
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var take_mini_juego: Node3D = $ConedorSpriter/Scale_Sprite

var player

var Player_Enter:bool


#Edit Camara
var camara
var camara_save_rotation

@export var Use_reload:bool

func _ready() -> void:
	Set_Game()
	animation_player.play("RESET")
	player = get_tree().get_first_node_in_group("Player")
	camara = get_tree().get_first_node_in_group("Camara")
	
func Set_Game():
	if Mini_Juego:
		var i = Mini_Juego.instantiate()
		take.add_child(i)
		Mini_Juego_node = i

func _process(delta: float) -> void:
	Enter_Mini_Juego()
	

func Enter_Mini_Juego():
	if not Mini_Juego_node:
		return
	
	if Player_Enter and not Mini_Juego_node.In_Game:
		if Input.is_action_just_pressed("Take"):
			Mini_Juego_node.Run_Game = true
			player.state_machine.change_to("PlayerGameState")
			animation_player.play("enter")
			Edit_Camara(true)
			
	if Mini_Juego_node.Win_Dead == "WIN" or Mini_Juego_node.Win_Dead == "DEAD":
		if not Mini_Juego_node.In_Game:
			animation_player.play("close")
			
			

func Edit_Camara(Enter:bool):
	if not camara:
		return
	var Camara_2D = camara.get_node("Camera3D")
	if not Camara_2D:
		return
		
	if Enter:
		#Camara_2D.look_at(take_mini_juego.global_position, Vector3.UP)
		camara.Speed_To_Animation(0)
	else:
		var tween = create_tween()
		tween.tween_property(Camara_2D, "rotation_degrees", Vector3(-45, 0, 0), 0.2)
		camara.Speed_To_Animation(1)

	
func _on_player_enter_area_entered(area: Area3D) -> void:
	Player_Enter = true


func _on_player_enter_area_exited(area: Area3D) -> void:
	Player_Enter = false


func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	if anim_name == "close":
		Edit_Camara(false)
		player.state_machine.change_to("PlayerGroundState")
		if not Use_reload:
			return
		Mini_Juego_node.queue_free()
		Set_Game()
