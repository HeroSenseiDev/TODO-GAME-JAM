extends Node2D
@onready var texture_rect: TextureRect = $TextureRect
@onready var sub_label_time: RichTextLabel = $Control/subLabel_Time

var amp = 10
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	
	create_tween().tween_property(sub_label_time, "modulate", Color(1, 1, 1, 1), 2)
	var Colores = [
		Color.RED, 
		Color.WHITE, 
		Color.BLUE,
		Color.GREEN,
		Color.YELLOW,
	]
	create_tween().tween_property(texture_rect, "modulate", Colores[2], 2)
	for color in Colores:
		create_tween().tween_property(texture_rect, "modulate", color, 2).set_delay(3)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	
	
	sub_label_time.text = "[rainbow freq=1.0 sat=1.5 val=1.5][wave amp="+str(200)+ "freq=5.0 connected=1]" + "  YOU Win   "
	
	create_tween().tween_property(sub_label_time, "modulate", Color(1, 1, 1, 0), 2).set_delay(5)
	create_tween().tween_property(texture_rect, "modulate", Color(0, 0, 0, 1), 2).set_delay(5)
	
	amp -= delta
	if amp <= 0:
		get_tree().change_scene_to_file("res://Menus/enter_menu.tscn")
