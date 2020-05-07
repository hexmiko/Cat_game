extends Node2D

onready var music_principal = $principal
onready var music_boss = $boss
onready var music_entrefase = $entrefase




func _ready() -> void:
	music_principal.play()



func _input(event: InputEvent) -> void:
	if Input.is_action_just_pressed('r'):
		get_tree().reload_current_scene()
		pass

func _on_area_entrefase_body_entered(body: Node) -> void:
	if body.name == 'Cat':
		# parar a principal e tocar a entrefase
		music_principal.stop()
		music_boss.stop()
		music_entrefase.play()


func _on_area_boss_body_entered(body: Node) -> void:
	if body.name == 'Cat':
		#parar a entre fase e rodar a de boss
		music_entrefase.stop()
		music_boss.play()


func _on_area_entrefase2_body_entered(body: Node) -> void:
	if body.name == 'Cat':
		#parar a de boss e rodar a entre fase
		music_boss.stop()
		music_entrefase.play()


