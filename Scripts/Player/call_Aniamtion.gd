extends Node3D
class_name SET_Animation


@onready var animation_tree: AnimationTree = $Player/AnimationTree
var animation_finished:bool

func Set_Animation(velocity:Vector3, Use_Run_2:bool, Take_Items:bool, Use_Set_Power:bool, Speed_Transtion:float = 0.1):
	
	var Is_Run = (true if velocity.x != 0 or velocity.z != 0 else false)
	var tween = create_tween()
	
	animation_tree["parameters/Take_Items/blend_amount"] = 1 if Take_Items else 0
	animation_tree["parameters/Run_2/blend_amount"] = 1 if Use_Run_2 else 0
	
	if not Use_Set_Power:
		
		tween.tween_property(animation_tree, "parameters/Cargando/blend_amount", 0.0, Speed_Transtion)
		
		if Is_Run:
			if not Take_Items:
				tween.tween_property(animation_tree, "parameters/Static_to_Run/blend_amount", 1.0, Speed_Transtion)
			else:
				tween.tween_property(animation_tree, "parameters/Static_to_Run_Take/blend_amount", 1.0, Speed_Transtion)
		else:
			if not Take_Items:
				tween.tween_property(animation_tree, "parameters/Static_to_Run/blend_amount", 0.0, Speed_Transtion)
			else:
				tween.tween_property(animation_tree, "parameters/Static_to_Run_Take/blend_amount", 0.0, Speed_Transtion)
	else:
		
		tween.tween_property(animation_tree, "parameters/Cargando/blend_amount", 1.0, Speed_Transtion)

func Set_Animation_Take(How:String = "TAKE"):
	if How == "TAKE":
		animation_tree.set("parameters/Take/request", AnimationNodeOneShot.ONE_SHOT_REQUEST_FIRE)
	elif How == "SET":
		animation_tree.set("parameters/Set/request", AnimationNodeOneShot.ONE_SHOT_REQUEST_FIRE)

func Set_Animation_Choque(Speed:float = 1.0):
	animation_tree.set("parameters/Choque/request", AnimationNodeOneShot.ONE_SHOT_REQUEST_FIRE)

func _on_animation_tree_animation_finished(anim_name: StringName) -> void:
	animation_finished = false

#Como Usar:
	#if not player_gfx.animation_finished:  
		##"""
		##Aqui Le Ponen un variable Boolean cuando lo tenga un Objecto
		##Por Ejemplo:
			##if not player_gfx.animation_finished and not take Items:
				##...
		##"""
		#if Input.is_action_just_pressed("Take"):
			#player_gfx.animation_finished = true
			#player_gfx.Set_Animation_Take("TAKE")
		#
		##"""Y Para Cuando lo Tanga Se llama Asi;
			##if not player_gfx.animation_finished and take Items:
				##if Input.is_action_just_pressed("Take"):
					##player_gfx.animation_finished = true
					##player_gfx.Set_Animation_Take("SET")
			##Esto LLamara La Amacion de Soltar el Objecto.
		##"""
		#
				#
	#player_gfx.Set_Animation(
		#
	## Para Verificar si se esta Moviendo el Player
	#velocity, 
	#
	##Use_Run_2: Para Usar la Animation Run 2
	#false, 
	#
	## Take_Items: Esto para Verificar si tiene el Objecto, 
	##y reproducir esas Animation
	#false, 
	#
	## Use_Set_Power: Llama a la Animaicon de cargar, 
	## Esto Tienen que Ser limitarlo, 
	##para que solo se llame cuando no tenga un Objecto con el.
	#false, 
	#
	## Speed_Transtion: A la velocidad que va a pasar de Animacion a Animacion.
	#0.1 
	#
	#)
