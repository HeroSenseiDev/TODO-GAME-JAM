extends Node3D

@onready var sprite_3d: Sprite3D = $Sprite3D
@export var Mini_Juego: PackedScene

@export var exeption : bool = false
@export var type : String
@export var game : String
var Mini_Juego_node
@onready var take: SubViewport = $Take
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var take_mini_juego: Node3D = $ConedorSpriter/Scale_Sprite
@onready var take_mini_juego_2: Sprite3D = $ConedorSpriter/Scale_Sprite/Take_Mini_Juego2
@export var is_ship_game : bool
@onready var reload: Timer = $Reload
@export var reload_time = 10
var time_out:bool = true

var player
var Player_Enter:bool

var save_positon=Vector3()
#Edit Camara
var camara
var camara_save_rotation

@export var Use_reload:bool

func _ready() -> void:
	save_positon = self.global_position
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
	#print("todo esta hecho? ", GlobalVar.all_tasks_completed())


func Enter_Mini_Juego():
	if not Mini_Juego_node:
		return

	# Verifica si hay una excepción para este tipo de minijuego en GlobalVar
	var game_exemption = GlobalVar.Tarea_Terminada.has(type) and GlobalVar.Tarea_Terminada[type]
	var game_type = GlobalVar.Juegos_Terminado.has(game) and GlobalVar.Juegos_Terminado[game]
	
	#if is_ship_game and Player_Enter and not  Mini_Juego_node.In_Game and time_out and !player.is_carrying:
		#if not time_out:
			#if GlobalVar.all_tasks_completed():
				#player.can_set = true
				#if time_out == true and Input.is_action_just_pressed("Take") and not player.is_carrying:
					#Mini_Juego_node.Run_Game = true
					#player.state_machine.change_to("PlayerGameState")
					#animation_player.play("enter")
					#Edit_Camara(true)
					#time_out = false
	if Player_Enter and not Mini_Juego_node.In_Game and time_out and not player.is_carrying and !is_ship_game:
		if not time_out:
			player.can_set = false
		if exeption and not game_exemption:
				return  # Si se necesita una excepción y no está cumplida, no se ejecuta el minijuego
		if GlobalVar.Juegos_Terminado[game] == true:
				return
		player.can_set = true
		if time_out == true and Input.is_action_just_pressed("Take") and not player.is_carrying:
			# Si se debe verificar una excepción, comprueba antes de ejecutar el minijuego
			Mini_Juego_node.Run_Game = true
			player.state_machine.change_to("PlayerGameState")
			animation_player.play("enter")
			Edit_Camara(true)
			time_out = false
			
	# Verifica si el minijuego ha terminado
	if Mini_Juego_node.Win_Dead == "WIN" or Mini_Juego_node.Win_Dead == "DEAD":
		if Mini_Juego_node.Win_Dead == "WIN":
			GlobalVar.Juegos_Terminado[game] = true
		if Mini_Juego_node.In_Game == false:
			animation_player.play("close")
			player.can_set = false
			time_out = false

			if Mini_Juego_node.Win_Dead == "DEAD":
				reload.start(reload_time)
				create_tween().tween_property(sprite_3d, "modulate", Color(1,1,1,1), 0.5)


func Edit_Camara(Enter:bool):
	if not camara:
		return
	var Camara_2D = camara.get_node("Camera3D")
	if not Camara_2D:
		return
		
	if Enter == true:
		camara.use_Player_position = false
		self.global_position = Vector3(camara.global_position.x, 0, camara.global_position.z)
		camara.Speed_To_Animation(0)
		
	else:
		create_tween().tween_property(self, "global_position", save_positon, 0.2)
		camara.use_Player_position = true
		camara.Speed_To_Animation(1)

	
func _on_player_enter_area_entered(area: Area3D) -> void:
	if area in get_tree().get_nodes_in_group("Player"):
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


func _on_reload_timeout() -> void:
	time_out = true
	create_tween().tween_property(sprite_3d, "modulate", Color(1,1,1,0), 0.2)
