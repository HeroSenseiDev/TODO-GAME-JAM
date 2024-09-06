extends Node3D


var textura
@onready var sprite: Sprite3D = $Sprite



# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass

func Set_Pop(Speed:float, S_Size = Vector2(), S_Position = Vector2(), Max_Position = Vector3(0, 10, 0)):
	sprite.texture = textura
	sprite.region_rect.position = S_Position
	sprite.region_rect.size = S_Size
	create_tween().tween_property(
	sprite, "position", Max_Position, Speed)
	create_tween().tween_property(
	sprite, "modulate", Color(1, 1, 1, 1), Speed)
