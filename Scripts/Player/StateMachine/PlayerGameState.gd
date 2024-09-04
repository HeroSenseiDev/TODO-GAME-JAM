extends PlayerState

func enter():
	pass
	
func process(delta):
	player.velocity = Vector3.ZERO
	player.player_gfx.Set_Animation(Vector3.ZERO, false, false, false, 0.11)
