extends Node3D

@onready var puerta_l: Marker3D = $Puerta_L
@onready var puerta_r: Marker3D = $Puerta_R

@export var Speed_To_Open:float = 0.2
func Open():
	var tween = create_tween()
	tween.tween_property(puerta_l, "position", Vector3(0.75,0,0), Speed_To_Open)
	tween = create_tween()
	tween.tween_property(puerta_r, "position", Vector3(-0.75,0,0), Speed_To_Open)
func Close():
	var tween = create_tween()
	tween.tween_property(puerta_l, "position", Vector3(0,0,0), Speed_To_Open)
	tween = create_tween()
	tween.tween_property(puerta_r, "position", Vector3(0,0,0), Speed_To_Open)


func _on_area_3d_area_entered(area: Area3D) -> void:
	Open()


func _on_area_3d_area_exited(area: Area3D) -> void:
	Close()
