extends Area3D
class_name Destiny

signal MyObjectIsHere
signal ObjectOut
@export var my_object: Node3D
@export var alert: Sprite3D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	body_entered.connect(take_object)
	body_exited.connect(object_out)
	
func take_object(body):
	if my_object != null:
		if body.name == my_object.name:
			MyObjectIsHere.emit()
		
func object_out(body):
	if body is Player:
		ObjectOut.emit()
