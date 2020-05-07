extends AudioStreamPlayer

export(AudioStream) var trilha_sonora = load("res://src/sons/Áudio de A (online-audio-converter.com) (4).ogg")

func _ready() -> void:
	pass

func _input(event: InputEvent) -> void:
	if Input.is_action_just_pressed("q"):
		stream = trilha_sonora
	
