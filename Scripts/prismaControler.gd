extends CharacterBody2D

@export var VELO_MAX = 120
@export var ACELERACAO = VELO_MAX*10
@export var FRICCAO = VELO_MAX*100
@onready var eixos = Vector2.ZERO

func _physics_process(delta):
	move(delta)
	
func get_input_eixos():
	eixos = Input.get_vector("esquerda", "direita", "cima", "baixo")
	eixos.x = int(Input.is_action_pressed("direita")) - int(Input.is_action_pressed("esquerda"))
	eixos.y = int(Input.is_action_pressed("baixo")) - int(Input.is_action_pressed("cima"))
	return eixos.normalized()
	
func move(delta):
	eixos = get_input_eixos()
	
	if eixos == Vector2.ZERO:
		aplica_friccao(FRICCAO*delta)
		
	else:
		aplica_movimento(eixos*ACELERACAO*delta)
		
	move_and_slide()
	
func aplica_friccao(amount):
	if velocity.length() > amount:
		velocity -= velocity.normalized()*amount
	else:
		velocity = Vector2.ZERO
		
func aplica_movimento(accel):
	velocity += accel
	velocity = velocity.limit_length(VELO_MAX)
	
func morte():
	print("O jogador morreu")
	get_tree().reload_current_scene()
	
#func getPoints():
	#print("mais um")
	#jogo_cena.addPoints()
