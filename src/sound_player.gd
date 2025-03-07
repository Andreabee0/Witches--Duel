extends Node

var player: AudioStreamPlayer


func _ready() -> void:
	player = AudioStreamPlayer.new()
	add_child(player)


func play_sound(sound: AudioStream, volume := 0.0):
	player.stream = sound
	player.volume_db = lerp(-15, 15, GlobalInfo.volume / 2) + volume
	player.play()
