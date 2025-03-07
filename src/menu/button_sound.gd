class_name ButtonSound
extends Button

@export var sound: AudioStream
@export var volume := 0.0


func _ready() -> void:
	pressed.connect(_on_pressed)


func _on_pressed():
	SoundPlayer.play_sound(sound, volume)
