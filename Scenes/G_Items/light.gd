extends Node3D
var animacion_muerta

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.
	$DirectionalLight3D.visible = false

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if GlobalVar.Tarea_Terminada["BateriaCargada"] == true and not animacion_muerta:
		play_animation()
		
func play_animation():
	$AnimationPlayer.play("Blinding")


func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	$AnimationPlayer.stop()
	$DirectionalLight3D.visible = true
	animacion_muerta = true
