extends MeshInstance3D
@onready var object_detection: Destiny = $ObjectDetection
var player : Player
@onready var posicion_bateria_cargada: Node3D = $PosicionBateriaCargada
@onready var charging_time: Timer = $ChargingTime
@onready var animation_player: AnimationPlayer = $Sprite3D/AnimationPlayer

func _ready() -> void:
	player = get_tree().get_first_node_in_group("Player")
	object_detection.MyObjectIsHere.connect(battery_is_here)
	object_detection.ObjectOut.connect(battery_is_not_here)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var overlapping_bodies : Array[Node3D] = object_detection.get_overlapping_bodies()
	for body in overlapping_bodies:
		if body is Player:
			if player.can_set and Input.is_action_just_pressed("Take"):
				object_detection.my_object.reparent(posicion_bateria_cargada)
				object_detection.my_object.global_position = posicion_bateria_cargada.global_position
				object_detection.my_object.global_rotation = posicion_bateria_cargada.global_rotation
				player.is_carrying = false
				GameManager.battery_is_charging = true
				$Sprite3D.visible = true
				animation_player.play("Charging")
				charging_time.start()

func battery_is_here():
	if object_detection.my_object.is_charged == false and player.is_carrying:
		player.can_set = true
		
func battery_is_not_here():
	player.can_set = false
	if object_detection.my_object != null:
		if object_detection.my_object.is_charged and player.carrying_object == object_detection.my_object:
			$Sprite3D.visible = false


func _on_charging_time_timeout() -> void:
	GameManager.battery_is_charging = false
	if object_detection.my_object == null:
		return
	if object_detection.my_object != null:
		object_detection.my_object.is_charged = true
