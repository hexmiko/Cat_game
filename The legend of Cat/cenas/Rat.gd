extends Actors

onready var sprite = $rat

var dano: bool = false

func _ready() -> void:
	velocity.x = -speed.x # se mover
	pass


func _physics_process(delta: float) -> void:
	velocity.y += gravity * delta
	
	if is_on_wall() or dano: # ficar trocando de direção ao bater na parede
		velocity *= -1.0
		sprite.flip_h = (velocity.x > 0) # genial, não pensei nisso
		dano = false
	
	
	velocity.y = move_and_slide(velocity, FLOOR_NORMAL).y 
	
	if not cheque_vida():
		queue_free()



func _on_Enemydetector_area_entered(area: Area2D) -> void:
	if area.name == 'area_do_chute':
		$AnimationPlayer.play("dano")
		dano = true
		life -= 1
