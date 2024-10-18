extends CharacterBody2D

@export var VELO = 160
@export var nav_agent: NavigationAgent2D

@onready var anim = $AnimatedSprite2D

var alvo= null
var posicaoInicial = Vector2.ZERO

func _ready():
	posicaoInicial = self.global_position
	
	nav_agent.path_desired_distance = 4
	nav_agent.target_desired_distance = 4
	
	anim.play("default")
	
func _physics_process(_delta):
	if nav_agent.is_navigation_finished():
		return
		
	var eixo = to_local(nav_agent.get_next_path_position()).normalized()
	var new_velocity = eixo*VELO
	
	atualizar_direcao(eixo)
	
	if nav_agent.avoidance_enabled:
		nav_agent.set_velocity(new_velocity)
	else:
		_on_navigation_agent_2d_velocity_computed(new_velocity)
	
	move_and_slide()
	
func atualizar_direcao(eixo: Vector2):
	var margem = 0.1
	
	if abs(eixo.x) > abs(eixo.y):  # Movimento horizontal prevalece
		if eixo.x < margem:
			anim.rotation_degrees = 0  # Direita
			anim.flip_h = false
		elif eixo.x > -margem:
			anim.rotation_degrees = 0  # Esquerda
			anim.flip_h = true
	else:  # Movimento vertical prevalece
		if eixo.y > -margem:
			anim.rotation_degrees = -90  # Para cima
			anim.flip_h = false
		elif eixo.y < margem:
			anim.rotation_degrees = 90  # Para baixo
			anim.flip_h = false

func rePath():
	if alvo:
		nav_agent.target_position = alvo.global_position
		
	else:
		nav_agent.target_position = posicaoInicial
	
func reposition():
	position = posicaoInicial

func _on_re_time_timeout():
	rePath()

func _on_area_2d_area_entered(area):
	alvo = area.owner

func _on_area_2d_area_exited(area):
	if area.owner == alvo:
		alvo = null
		

func _on_area_morte_body_entered(body):
	if body.name == "Prisma":
		body.gerenciaVidas()


func _on_navigation_agent_2d_velocity_computed(safe_velocity):
	velocity = safe_velocity
