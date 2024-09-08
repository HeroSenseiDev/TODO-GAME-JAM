extends Node3D
@onready var alert: Sprite3D = $Alert
@export var puerta : Trash_Door
@onready var posicion_basura_muerta: Node3D = $PosicionBasuraMuerta
var basura_limpia : bool
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	basura_limpia = false

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if GlobalVar.Tarea_Terminada["BasuraRecogida"] == true:
		alert.visible = false
	if GlobalVar.Juegos_Terminado["Basura"] == true and not basura_limpia:
		puerta.Open()
		await get_tree().create_timer(1.5).timeout
		var tween = get_tree().create_tween()
		tween.tween_property(self, "global_position", posicion_basura_muerta.global_position, 0.7)
		basura_limpia = true
		await get_tree().create_timer(0.7).timeout
		puerta.Close()
