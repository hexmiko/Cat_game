extends Actors

onready var cat_position = get_parent().get_node("Cat")
onready var sprite = $rat
onready var gambiarra = get_parent().get_node("gambiarra")


var _local: float
var weak: bool = false

func _ready() -> void:
	velocity.x = -speed.x # se mover
	$AnimationPlayer.play("andando")
	pass


func _physics_process(delta: float) -> void:
	velocity.y += gravity * delta
	
	
	if not weak:
		_local = cat_position.position.x - position.x
		follow(_local)
	
	velocity.y = move_and_slide(velocity, FLOOR_NORMAL).y 
	sprite.flip_h =  (velocity.x > 0)
	if not cheque_vida():
		queue_free()
		gambiarra.queue_free()
		
	
	


# TODO: Encrementar o que o boss vai fazer agora que ele pode seguir algo
func follow(place):
	if place < 0:
		move_esquerda()
		
	elif place > 0:
		move_direita()


func move_esquerda():
	velocity.x += -speed.x * get_physics_process_delta_time()
	pass


func move_direita():
	velocity.x += speed.x * get_physics_process_delta_time()
	pass


func _on_detector_area_entered(area: Area2D) -> void:
	if area.name == 'area_do_chute' and weak:
		life -= 1
		$AnimationPlayer.play("andando")
		$AnimationPlayer.play("dano")
		weak = false
		

func _on_AnimationPlayer_animation_finished(anim_name: String) -> void:
	if anim_name == "levantar":
		weak = false
		$AnimationPlayer.play("andando")


func _on_detector_body_entered(body: Node) -> void:
	if body.name == "espinhos":
		weak = true
		$AnimationPlayer.play("levantar")
		velocity.x = 0
