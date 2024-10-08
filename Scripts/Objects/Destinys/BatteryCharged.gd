extends MeshInstance3D
@onready var carrying_detection: Destiny = $ObjectDetection
var can_accept : bool
@onready var alert: Sprite3D = $Sprite3D
var player : Player
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	player = get_tree().get_first_node_in_group("Player")
	carrying_detection.MyObjectIsHere.connect(battery_is_here)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if can_accept and Input.is_action_just_pressed("Take"):
		if carrying_detection.my_object != null:
			carrying_detection.my_object.queue_free()
			player.bateria_soltar.play()
			player.is_carrying = false
			alert.visible = false
			GlobalVar.Tarea_Terminada["BateriaCargada"] = true
			print(GlobalVar.Tarea_Terminada["BateriaCargada"])

func battery_is_here():
	if carrying_detection.my_object.is_charged == true:
		player.can_set = true
		can_accept = true
