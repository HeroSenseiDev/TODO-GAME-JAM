extends CanvasLayer

@onready var video: AnimatedSprite2D = $Video
@onready var pressed: RichTextLabel = $Control/Pressed
var target_position = Vector2()
const NAVE = "res://Scenes/G_Items/nave.tscn"

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	video.play("Enter")
	target_position = video.position
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	_move_video_to_mouse()


	if Input.is_action_just_pressed("Take"):
		get_tree().change_scene_to_file(NAVE)
func _move_video_to_mouse():

	var mouse_position = get_viewport().get_mouse_position()
	
	# Limita la posición del ratón dentro de los rangos especificados
	var target_x = mouse_position.x
	if target_x > 720:
		target_x = 720
	elif target_x < 550:
		target_x = 550
	
	var target_y = mouse_position.y
	if target_y > 400:
		target_y = 400
	elif target_y < 315:
		target_y = 315
	
	var target = Vector2(target_x, target_y)
	
	# Crea el tween y anima la propiedad de posición del objeto "video"
	var tween = create_tween()
	tween.tween_property(video, "position", target, 20)
