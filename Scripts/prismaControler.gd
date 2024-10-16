extends CharacterBody2D

@export var VELO_MAX = 120
@export var ACELERACAO = VELO_MAX*10
@export var FRICCAO = VELO_MAX*100
@onready var eixos = Vector2.ZERO
@onready var anim = $AnimatedSprite2D

func _ready():
	anim.play("default")
	
func _physics_process(delta):
	move(delta)
	atualizar_anim()

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
	
func atualizar_anim():
	if eixos == Vector2.ZERO:
		if anim.animation != "default":
			anim.play("default")
	else:
		if anim.animation != "moving":
			anim.play("moving")
		atualizar_direcao()

func atualizar_direcao():
	if eixos.x != 0:
		anim.rotation_degrees = 0
		anim.flip_h= eixos.x > 0
	elif eixos.y<0:
		anim.rotation_degrees = 90
	elif eixos.y>0:
		anim.rotation_degrees = -90
		if eixos.x < 0:
			anim.flip_h= eixos.x > 0
		else:
			anim.flip_h= eixos.x < 0
			
func morte():
	print("O jogador morreu")
	get_tree().reload_current_scene()
	
#func getPoints():
	#print("mais um")
	#jogo_cena.addPoints()
