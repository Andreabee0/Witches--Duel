extends Range


@export var sound: AudioStream


func _ready() -> void:
	value_changed.connect(_on_changed)


func _on_changed(_value: float):
	SoundPlayer.play_sound(sound)
