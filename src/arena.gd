extends Node


func _ready() -> void:
	for info: PlayerInfo in Players.info.values():
		info.create_player(self)
