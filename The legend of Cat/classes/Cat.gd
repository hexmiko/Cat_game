extends Actors

onready var sprite = get_node("sprite_base_addon_2012_12_14")
onready var state = get_node("AnimationTree").get("parameters/playback")
onready var camera = $Camera2D

var morreu = false



func _physics_process(delta: float) -> void:
	if not morreu:
		var is_jump_interrumped: bool = Input.is_action_just_released("ui_up") and velocity.y < 0.0
		var direction = calc_direcao()
		velocity = calc_velocidade(velocity, direction, speed, is_jump_interrumped)
		velocity = move_and_slide(velocity, FLOOR_NORMAL)
		switchAnimation()
		switchCamera()
		if not cheque_vida() and not morreu:
			print('morreu')
			state.travel("morte")
			morreu = true


func calc_direcao() -> Vector2:
	return Vector2( # É basicamente uma seta dizendo pra onde se mover
		Input.get_action_strength("ui_right") - 
		Input.get_action_strength('ui_left'), 
		-1.0 if Input.is_action_just_pressed("ui_up") and
		 is_on_floor() else 0.0
	)


func calc_velocidade(
		linear_velocity: Vector2,
		direction: Vector2,
		speed: Vector2,
		is_jump_interrumped: bool
	) -> Vector2:
	var out: = linear_velocity
	out.x = speed.x * direction.x
	if out.x < 0:
		sprite.flip_h = true
		$area_do_chute.rotation_degrees = 180
	elif out.x > 0:
		sprite.flip_h = false
		$area_do_chute.rotation_degrees = 0
		
	out.y += gravity * get_physics_process_delta_time()
	if direction.y == -1.0:
		out.y = speed.y * direction.y
	if is_jump_interrumped:
		out.y = 0.0
	return out


func switchAnimation():
	if velocity.x != 0:
		state.travel("andando")
	else:
		state.travel("parado")
	if Input.is_action_just_pressed("c"):
		state.travel("chute_alto")
	if not is_on_floor():
		state.travel("pulo")


func switchCamera():
	if position.y >= 800:
		camera.limit_top = 700
		camera.limit_right = 2800
	if position.x >= 2800:
		camera.limit_left = 2800
		camera.limit_right = 3770
	if position.x >= 3770:
		camera.limit_right = 4832


func _on_detectorRatos_body_entered(body: Node) -> void:
	if body.name == "espinhos" or "Rat" in body.name and not morreu:
		$AnimationPlayer.play("dano")
		life -= 1
		$Camera2D/CanvasLayer/Label.text = "Vidas: %d" % life
	
