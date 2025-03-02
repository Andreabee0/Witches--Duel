extends Button


@export var sound: AudioStream


func _ready() -> void:
	pressed.connect(_on_pressed)


func _on_pressed():
	SoundPlayer.play_sound(sound)
