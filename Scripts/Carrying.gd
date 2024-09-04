extends StaticBody3D
var player : Player
@export var destino : Node3D
@export var offset : Vector3

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	player = get_tree().get_first_node_in_group("Player")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if not player.player_gfx.animation_finished and !player.is_carrying:
		if player.can_take:
			if Input.is_action_just_pressed("Take"):
				set_collision_layer_value(4, true)
				
				# Calcular la rotación hacia el objeto
				var direction_to_object = (global_transform.origin).normalized()
				var target_rotation_y = atan2(direction_to_object.x, direction_to_object.z)
				# Rotar suavemente al jugador hacia el objeto
				player.rotation.y = lerp_angle(player.rotation.y, target_rotation_y, delta)
				player.is_carrying = true
				player.player_gfx.animation_finished = true
				player.player_gfx.Set_Animation_Take("TAKE", 3, 3)
				#global_position = player.carrying_offset.global_position
				await get_tree().create_timer(0.3).timeout
				var tween = get_tree().create_tween()
				tween.tween_property(self, "global_position", player.carrying_offset.global_position + offset, 0.05)
				global_rotation = player.carrying_offset.global_rotation
				self.reparent(player.carrying_offset)
				player.can_take = false
		

func _on_area_3d_body_entered(body: Node3D) -> void:
	if body.is_in_group("Player"):
		if not player.is_carrying:
			player.can_take = true
		

func _on_area_3d_body_exited(body: Node3D) -> void:
	if body.is_in_group("Player"):
		player.can_take = false
