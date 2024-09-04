extends CharacterBody2D


@export var SPEED = 300.0
@export var Max_Arrastre: float = 100
@export var Max_Arrastre_Rotation: float = 30
var Arrastre:float
@onready var rot: Marker2D = $Rot


var Nave_Player_Dead:bool

func _physics_process(delta: float) -> void:
	
	if get_parent().Run_Game:
		Move(delta)

func Move(delta):
	if Input.is_action_pressed("ui_left"):
		if Arrastre >= -Max_Arrastre: 
			Arrastre -= 20  
		if rot.rotation_degrees >= -Max_Arrastre_Rotation:
			rot.rotation_degrees  -= 10
	else:
		if rot.rotation_degrees < 0:
			rot.rotation_degrees += Max_Arrastre * delta
			
	if Input.is_action_pressed("ui_right"):
		if Arrastre <= Max_Arrastre: 
			Arrastre += 20 
		if rot.rotation_degrees <= Max_Arrastre_Rotation:
			rot.rotation_degrees += 10 
	else:
		if rot.rotation_degrees > 0:
			rot.rotation_degrees -= Max_Arrastre * delta
			
			
	var direction := Input.get_axis("ui_left", "ui_right")
	
	if direction or Arrastre != 0:
		
		if Arrastre > 0:
			Arrastre -= Max_Arrastre * delta

		if Arrastre < 0:
			Arrastre += Max_Arrastre * delta

		velocity.x = direction * SPEED * 100  * delta 
		velocity.x += Arrastre 
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
	move_and_slide()


func _on_kill_my_area_entered(area: Area2D) -> void:
	Nave_Player_Dead = true
