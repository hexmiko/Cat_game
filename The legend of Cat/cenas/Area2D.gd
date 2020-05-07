extends Area2D

onready var music = $anotherSong
onready var trilha = get_parent().get_node("trilhasonora")

func _ready() -> void:
	pass





# todo consertar isso
func _on_outraMuscica_body_entered(body: Node) -> void:
	if body.name == "Cat":
		trilha.stop()
		music.play()
	


