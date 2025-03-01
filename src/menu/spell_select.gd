@tool
class_name SpellSelectMenu
extends Control

signal back_pressed

const BASE_PLAYER := preload("res://scenes/components/player_display.tscn")

@export var player_count := 0:
	set = set_player_count

var players: Array[Node] = []


func set_player_count(value: int):
	player_count = value
	Util.update_object_count(players, player_count, make_player)


func make_player() -> Node:
	var ret := BASE_PLAYER.instantiate()
	$VerticalContainer/PlayersContainer.add_child(ret)
	return ret


func _ready() -> void:
	if Engine.is_editor_hint():
		set_player_count(player_count)


func _on_back_pressed():
	back_pressed.emit()
