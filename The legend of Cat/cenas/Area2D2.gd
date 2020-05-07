extends Area2D

onready var trilha = get_parent().get_node("outraMuscica/anotherSong")
onready var bossSong = $bossSong
onready var outramusica = get_parent().get_node("musicaoutra/anotherSong2")

func _ready() -> void:
	pass


func _on_Area2D2_body_entered(body: Node) -> void:
	if body.name == 'Cat':
		trilha.stop()
		outramusica.stop()
		bossSong.play()
