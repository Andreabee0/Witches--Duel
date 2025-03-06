extends Node2D

func _ready() -> void:
	for selections: Selections in Players.selections.values():
		selections.create_player(self)