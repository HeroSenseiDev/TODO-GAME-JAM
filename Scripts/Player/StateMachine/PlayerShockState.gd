extends PlayerState
@onready var timer: Timer = $Timer
@onready var knockback_duration: Timer = $KnockbackDuration


func enter():
	knockback_duration.start()
	timer.start()
	knockback()
	
func process(_delta):
	print(player.velocity.z)

func knockback():
	player.velocity = player.knockback_direction
	player.move_and_slide()


func _on_timer_timeout() -> void:
	player.velocity.z = 0
	state_machine.change_to("PlayerGroundState")


func _on_knockback_duration_timeout() -> void:
	player.velocity.x = 0
	player.velocity.z = 0
