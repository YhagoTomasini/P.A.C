extends Control

@onready var music = $AudioMusicTheme

func _ready() -> void:
	music.play()

func _on_play_pressed() -> void:
	get_tree().change_scene_to_file("res://Cenas/jogo_cena.tscn")


func _on_leave_pressed() -> void:
	get_tree().quit()
