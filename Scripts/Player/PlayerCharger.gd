extends StaticBody3D
@onready var player_detection: Area3D = $PlayerDetection
var is_in_area : bool
var player : Player
@onready var candado: Sprite3D = $Candado
@onready var cooldown: Timer = $Cooldown

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	player = get_tree().get_first_node_in_group("Player")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var overlapping_bodies : Array[Node3D] = player_detection.get_overlapping_bodies()
	for body in overlapping_bodies:
		if body is Player:
			player.can_take = true
			if Input.is_action_just_pressed("Take"):
				player.battery_timer.stop()
				player.battery_timer.start()


func _on_player_detection_body_exited(body: Node3D) -> void:
	if body is Player:
		player.can_take = false 
