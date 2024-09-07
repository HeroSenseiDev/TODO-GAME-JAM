extends CanvasLayer


var Enter_Scena:String
var how_set:String = "CHANGE_SCENE"
@onready var animation_player: AnimationPlayer = $AnimationPlayer



func call_Enter():
	animation_player.play("Enter")

func Enter():
	if how_set == "CHANGE_SCENE":
		get_tree().change_scene_to_file(Enter_Scena)
	else:
		get_tree().reload_current_scene()
