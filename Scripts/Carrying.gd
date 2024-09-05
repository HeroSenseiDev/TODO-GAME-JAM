extends Area3D
class_name CarryingDetect
signal CanCarrying
signal NotCanCarrying
func _ready() -> void:
	body_entered.connect(player_can_take)
	body_exited.connect(player_out)
	area_entered.connect(destiny)
func player_can_take(body):
	if body is Player:
		CanCarrying.emit()
func player_out(body):
	if body is Player:
		NotCanCarrying.emit()
func destiny(area):
	if area is Destiny:
		area.take_object(get_parent())
