extends CanvasLayer


@onready var texto_do_contador_de_fps : Label = $Control/Label
var contador_de_fps : float = 0.0

func _process(delta: float) -> void:
	mostrar_fps()

func mostrar_fps() -> void:
	contador_de_fps = Engine.get_frames_per_second()
	texto_do_contador_de_fps.text = "FPS: " + str(contador_de_fps)
