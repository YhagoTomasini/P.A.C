extends Control

@onready var scoreValue: Label = %ScoreValue
@onready var highScoreValue: Label = %HighScoreValue
@onready var textFinal: Label = %"Label _ Morte"
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if DadosGlobais.highScore < DadosGlobais.score:
		DadosGlobais.highScore = DadosGlobais.score
	
	if DadosGlobais.score >= 17:
		textFinal.text = "VITORIA\n:)"
	else:
		textFinal.text = "MORREU\n;-;"
		
	
	scoreValue.text = str(DadosGlobais.score)
	highScoreValue.text = str(DadosGlobais.highScore)


func _on_restart_pressed() -> void:
	get_tree().change_scene_to_file("res://Cenas/jogo_cena.tscn")
	DadosGlobais.score = 0
	
func _on_back_menu_pressed() -> void:
	get_tree().change_scene_to_file("res://Cenas/Menu_Inicial.tscn")
	DadosGlobais.score = 0
