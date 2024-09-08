extends Node3D
class_name Trash_Door
@onready var animation_tree: AnimationTree = $AnimationTree
@export var Speed_to_Open_or_Close: float = 0.2
@onready var luz: Sprite3D = $Luz

var Win_Game:bool
var Is_Open:bool = true

func Open():
	var tween = create_tween()
	tween.tween_property(animation_tree, "parameters/Close_Open/blend_amount", 1,Speed_to_Open_or_Close)
	tween = create_tween()
	tween.tween_property(luz, "modulate",Color(0.355, 0.995, 0.892, 1), Speed_to_Open_or_Close)
func Close():
	var tween = create_tween()
	tween.tween_property(animation_tree, "parameters/Close_Open/blend_amount", 0,Speed_to_Open_or_Close)
	tween = create_tween()
	tween.tween_property(luz, "modulate",Color(0.355, 0.995, 0.892, 0), Speed_to_Open_or_Close)
func _process(delta: float) -> void:
	
	if Input.is_action_just_pressed("Take"):
		if Is_Open and Win_Game:
			Open()
			Is_Open = not Is_Open
		else:
			Close()
			Is_Open = not Is_Open

func _on_area_3d_area_entered(area: Area3D) -> void:
	Win_Game = true #Aqui ponen Si gano el mini juego o no.
	print("hola")
