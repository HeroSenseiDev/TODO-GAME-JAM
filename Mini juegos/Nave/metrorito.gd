extends Node2D


var Speed = 400

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	self.global_position.y += Speed * delta
	self.rotation_degrees += Speed/4 * delta
	
	if self.global_position.y >= 1000:
		queue_free()
