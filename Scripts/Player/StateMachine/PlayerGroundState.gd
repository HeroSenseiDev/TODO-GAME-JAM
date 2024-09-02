extends PlayerState

# Variables para controlar el movimiento
var acceleration := 100.0
var friction := 100.0
#var max_speed := 10.0
var velocity := Vector3.ZERO

func enter():
	player.anim.play("Idle")



func process(delta):
	if player.fray_cast.is_colliding():
		print("colisione")
		var collider = player.fray_cast.get_collider()
		if collider is Node3D:
			if collider.is_in_group("Obstacles"):
				player.anim.play("Shock")
				state_machine.change_to("PlayerShockState")
	# Obtener la dirección de entrada del jugador
	var input_dir := Input.get_vector("Left", "Right", "Forward", "Back")
	var direction := Vector3(input_dir.x, 0, input_dir.y).normalized()

	# Acelerar en la dirección del input
	if direction != Vector3.ZERO:
		velocity.x = move_toward(velocity.x, direction.x * player.speed, acceleration * delta)
		velocity.z = move_toward(velocity.z, direction.z * player.speed, acceleration * delta)
		
		# Rotar el personaje hacia la dirección del movimiento
		var target_rotation_y := atan2(direction.x, direction.z)
		player.rotation.y = lerp_angle(player.rotation.y, target_rotation_y, delta * 25)
	else:
		# Aplicar fricción cuando no hay input
		velocity.x = move_toward(velocity.x, 0, friction * delta)
		velocity.z = move_toward(velocity.z, 0, friction * delta)

	# Mover al personaje
	player.velocity.x = velocity.x
	player.velocity.z = velocity.z
