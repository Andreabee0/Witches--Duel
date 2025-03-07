extends Node

const VICTORY := preload("res://scenes/menu/victory.tscn")
const FADE_TIME = 5

var fade := -1.0

@onready var hud: GlobalHud = $CanvasLayer/GlobalHud


func _ready() -> void:
	RenderingServer.set_default_clear_color(Color.BLACK)
	GlobalInfo.in_battle = true
	GlobalInfo.current_arena_bounds = $Bounds.get_global_rect()
	for info: PlayerInfo in Players.info.values():
		info.create_player(self)
	if Players.info.is_empty():
		add_child(load("res://scenes/player.tscn").instantiate())


func _process(delta: float) -> void:
	if fade >= 0:
		fade += delta
		if fade > FADE_TIME:
			fade = -1
			get_tree().change_scene_to_packed(VICTORY)
		else:
			hud.set_fade(fade / FADE_TIME)
	else:
		var alive := 0
		for info: PlayerInfo in Players.info.values():
			if info.get_remaining_health() > 0:
				alive += 1
		if alive == 1:
			GlobalInfo.in_battle = false
			fade = 0.0
