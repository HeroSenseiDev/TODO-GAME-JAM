extends Node3D



@export var _player:Node3D
@export var limite_Position = Vector2()
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if _player:
		var tween = create_tween()
		tween.tween_property(self, "global_position", _player.global_position, 0.2 )
		
