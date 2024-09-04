extends PlayerState


# Variables para controlar el movimiento
var acceleration := 100.0
var friction := 100.0
#var max_speed := 10.0
var velocity := Vector3.ZERO


func enter():
	pass



func process(delta):

	var input_dir := Input.get_vector("Left", "Right", "Forward", "Back")
	var direction := Vector3(input_dir.x, 0, input_dir.y).normalized()

	# Acelerar en la dirección del input
	if direction != Vector3.ZERO:
		velocity.x = move_toward(velocity.x, direction.x * player.speed, acceleration * delta)
		velocity.z = move_toward(velocity.z, direction.z * player.speed, acceleration * delta)
		
		# Rotar el personaje hacia la dirección del movimiento
		var target_rotation_y := atan2(direction.x, direction.z)
		player.rotation.y = lerp_angle(player.rotation.y, target_rotation_y, delta * 10)
		
		
	else:
		# Aplicar fricción cuando no hay input
		velocity.x = move_toward(velocity.x, 0, friction * delta)
		velocity.z = move_toward(velocity.z, 0, friction * delta)

	# Mover al personaje
	player.velocity.x = velocity.x
	player.velocity.z = velocity.z
	player.player_gfx.Set_Animation(player.velocity, true, player.is_carrying, false, 0.1)

func _on_trip_detection_body_entered(body: Node3D) -> void:
	if body.is_in_group("Obstacles"):
		player.player_gfx.Set_Animation_Choque(1.0)
		player.knockback_direction = -player.velocity.normalized() * 15
		state_machine.change_to("PlayerShockState")
