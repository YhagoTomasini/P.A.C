extends CharacterBody2D

@export var VELO = 50
@export var nav_agent: NavigationAgent2D

var alvo= null
var posicaoInicial = Vector2.ZERO

func _ready():
	posicaoInicial = self.global_position
	
	nav_agent.path_desired_distance = 4
	nav_agent.target_desired_distance = 4
	
func _physics_process(_delta):
	if nav_agent.is_navigation_finished():
		return
		
	var eixo = to_local(nav_agent.get_next_path_position()).normalized()
	velocity = eixo*VELO
	
	move_and_slide()
	
func rePath():
	if alvo:
		nav_agent.target_position = alvo.global_position
		
	else:
		nav_agent.target_position = posicaoInicial
	

func _on_re_time_timeout():
	rePath()

func _on_area_2d_area_entered(area):
	alvo = area.owner

func _on_area_2d_area_exited(area):
	if area.owner == alvo:
		alvo = null
		

func _on_area_morte_body_entered(body):
	if body.name == "Prisma":
		body.morte()
