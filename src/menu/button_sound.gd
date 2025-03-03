class_name ButtonSound
extends Button


@export var sound: AudioStream


func _ready() -> void:
	pressed.connect(_on_pressed)


func _on_pressed():
	print("on press!")
	SoundPlayer.play_sound(sound)
