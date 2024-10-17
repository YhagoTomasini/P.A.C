extends Control



func _ready() -> void:
	pass





func _on_play_pressed() -> void:
	get_tree().change_scene_to_file("res://Cenas/jogo_cena.tscn")


func _on_leave_pressed() -> void:
	get_tree().quit()
