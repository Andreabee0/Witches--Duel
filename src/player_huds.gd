class_name GlobalHud
extends Control

const BASE_HUD := preload("res://scenes/player_hud.tscn")

var huds: Array[PlayerHud] = []

@onready var container := $Margin/Container
@onready var cover: ColorRect = $ScreenCover


func _ready() -> void:
	Util.update_object_count(huds, Players.get_joined_count(), make_hud)


func make_hud() -> PlayerHud:
	var instance: PlayerHud = BASE_HUD.instantiate()
	container.add_child(instance)
	var player := Players.joined_order[huds.size()]
	instance.set_player(player)
	Players.info[player].damaged.connect(handle_damage.bind(player, huds.size()))
	return instance


func handle_damage(_amount: int, player: int, index: int) -> void:
	if Players.info[player].get_remaining_health() <= 0:
		remove_hud(index)


func remove_hud(index: int) -> void:
	if huds[index]:
		huds[index].queue_free()
		huds[index] = null


func set_fade(value: float) -> void:
	cover.color.a = value
