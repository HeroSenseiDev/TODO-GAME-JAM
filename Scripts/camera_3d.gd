extends Node3D



@export var _player:Node3D
@export var limite_Position = Vector2()
@onready var animation_tree: AnimationTree = $AnimationTree
var use_Player_position:bool = true

func _ready() -> void:
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if use_Player_position == true and _player:
		var tween = create_tween()
		tween.tween_property(self, "global_position", _player.global_position, 0.2 )

# Velosidad del la Animacion
func Speed_To_Animation(Speed:float=1):
	animation_tree["parameters/Speed/scale"] = Speed


# Para Cuando Pasa Algo Muy Fuerte en la Scena
func Set_Camara_Golpe(Fuerza:float=2):
	animation_tree["parameters/Fuerza/scale"] = Fuerza
	animation_tree.set("parameters/Golpe/request", AnimationNodeOneShot.ONE_SHOT_REQUEST_FIRE)
	
