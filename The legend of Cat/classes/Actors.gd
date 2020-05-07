extends KinematicBody2D
class_name Actors

export var life: int = 10 

export var speed = Vector2(200, 1000)
export var gravity = 2000

const FLOOR_NORMAL = Vector2.UP

var velocity = Vector2.ZERO
var vivo: bool = true

func cheque_vida() -> bool:
	if life <= 0:
		vivo = false
	return vivo
