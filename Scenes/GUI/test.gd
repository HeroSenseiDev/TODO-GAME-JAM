extends Label


# Supongamos que tienes dos variables: real_time y Limit_Time
var real_time = 5
var Limit_Time = 10

func _ready() -> void:
	# Usamos el método format() para formar el texto
	text = str(real_time) + " / " + str(Limit_Time)
