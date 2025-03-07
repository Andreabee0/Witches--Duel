extends Node


func _ready() -> void:
	RenderingServer.set_default_clear_color(Color.BLACK)
	GlobalInfo.current_arena_bounds = $Bounds.get_global_rect()
	for info: PlayerInfo in Players.info.values():
		info.create_player(self)
	if Players.info.is_empty():
		add_child(load("res://scenes/player.tscn").instantiate())
