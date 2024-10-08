extends StaticBody3D
@onready var object_detection: Destiny = $ObjectDetection
@export var myObject : Node3D
var player : Player

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	object_detection.my_object = myObject
	player = get_tree().get_first_node_in_group("Player")
	object_detection.MyObjectIsHere.connect(trash_is_here)
	object_detection.ObjectOut.connect(trash_is_not_here)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
		if player.can_set and Input.is_action_just_pressed("Take"):
			object_detection.my_object.reparent(self)
			object_detection.my_object.global_position = global_position
			GlobalVar.BasuraEnSala[object_detection.name] = true
			player.is_carrying = false
func trash_is_here():
	player.can_set = true
	
func trash_is_not_here():
	player.can_set = false
