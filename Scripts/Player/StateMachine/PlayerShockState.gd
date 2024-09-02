extends PlayerState
@onready var timer: Timer = $Timer


func enter():
	timer.start()
	
func process(_delta):
	pass




func _on_timer_timeout() -> void:
	state_machine.change_to("PlayerGroundState")
