extends Node

const FADE_TIME = 3

var fade := -1.0

@onready var hud: GlobalHud = $CanvasLayer/GlobalHud


func _ready() -> void:
	RenderingServer.set_default_clear_color(Color.BLACK)
	GlobalInfo.current_arena_bounds = $Bounds.get_global_rect()
	if Players.info.is_empty():
		Players.make_dummy_info()
	for info: PlayerInfo in Players.info.values():
		info.create_player(self)


func _process(delta: float) -> void:
	if fade >= 0:
		fade += delta
		if fade > FADE_TIME:
			get_tree().change_scene_to_file("res://scenes/menu.tscn")
		else:
			hud.set_fade(fade / FADE_TIME)
	else:
		var alive := 0
		for info: PlayerInfo in Players.info.values():
			if info.get_remaining_health() > 0:
				alive += 1
		if alive == 1:
			GlobalInfo.battle_ended = true
			fade = 0.0
