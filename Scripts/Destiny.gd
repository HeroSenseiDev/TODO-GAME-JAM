extends MeshInstance3D
@export var objeto : Node3D
@export var alert : Sprite3D
var player : Player
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	player = get_tree().get_first_node_in_group("Player")
	alert.visible = true


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if player.can_set and player.is_carrying:
		if not player.player_gfx.animation_finished:
			if Input.is_action_just_pressed("Take"):
				player.player_gfx.animation_finished = true
				player.player_gfx.Set_Animation_Take("SET", 2, 2)
				objeto.queue_free()
				alert.visible = false
				player.is_carrying = false



func _on_area_3d_area_entered(area: Area3D) -> void:
	print(area.get_parent().name)
	if area.get_parent().name == objeto.name:
		player.can_set = true


func _on_area_3d_area_exited(area: Area3D) -> void:
	if area.get_parent().name == objeto.name:
		player.can_set = false
