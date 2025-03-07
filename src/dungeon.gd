extends Node


func _ready() -> void:
	for info: PlayerInfo in Players.info.values():
		info.create_player(self)
	if Players.info.is_empty():
		add_child(load("res://scenes/player.tscn").instantiate())
