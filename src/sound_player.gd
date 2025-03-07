extends Node


var player: AudioStreamPlayer


func _ready() -> void:
	player = AudioStreamPlayer.new()
	add_child(player)


func play_sound(sound: AudioStream):
	player.stream = sound
	player.volume_db = lerp(-10, 10, GlobalInfo.volume / 2)
	player.play()
