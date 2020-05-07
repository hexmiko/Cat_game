extends Actors

var morto: bool = false

func _process(delta: float) -> void:
	velocity.y += gravity * delta
	velocity.y = move_and_slide(velocity, FLOOR_NORMAL).y 


func _on_chute_entered(area: Area2D) -> void:
	if area.name == 'area_do_chute' and not morto:
		$AnimationPlayer.play("dano")
		life -= 1
		
		if life == 10:
			$AnimationPlayer.play("no_foots")
		elif life == 5:
			$AnimationPlayer.play("sem_tronco")
		elif life == 2:
			$AnimationPlayer.play("no_head")
		elif life <= 0:
			$AnimationPlayer.play("morte")
			morto = true
		
		
		
