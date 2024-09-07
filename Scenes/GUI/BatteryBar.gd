extends TextureProgressBar
class_name HealthPlayerBar
@export var battery_component : BatteryComponent

func on_ready():
	max_value = battery_component.max_health
	value = battery_component.current_health
	
	battery_component.onHealthChanged.connect(update_health)
	

func update_health(current_health):
	value = current_health
	if value <= 0:
		hide()
