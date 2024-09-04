extends Node
#class_name GameManager

var player : Player
var gui : GUI

func _ready() -> void:
	if not player:
		player = get_tree().get_first_node_in_group("Player")

func _process(delta: float) -> void:
	if not player or not gui:
		return

	if player.can_take == true:
		gui.interact_label.visible = true
	else:
		gui.interact_label.visible = false
			
	#if player.can_set:
		#gui.set_label.visible = true
	#else: 
		#gui.set_label.visible = false
