@tool
class_name SpellSelectMenu
extends Control

signal back_pressed

const BASE_PLAYER := preload("res://scenes/components/player_display.tscn")

@export var player_count := 0:
	set = set_player_count

var players: Array[Node] = []

@onready var spells_container: FlowContainer = $VerticalContainer/MainContainer/SpellsContainer


func set_player_count(value: int) -> void:
	player_count = value
	Util.update_object_count(players, player_count, make_player)


func make_player() -> Node:
	var ret := BASE_PLAYER.instantiate()
	$VerticalContainer/PlayersContainer.add_child(ret)
	var idx := players.size()
	ret.spell_slots = 4
	ret.perk_slots = 1
	if Engine.is_editor_hint():
		ret.set_color(PlayerColor.colors[idx])
	else:
		var player := Players.joined_order[idx]
		ret.set_color(Players.colors[player])
		ret.set_selections(Players.selections[player])
	return ret


func _ready() -> void:
	if Engine.is_editor_hint():
		set_player_count(player_count)
	else:
		set_player_count(Players.get_joined_count())


func _on_back_pressed() -> void:
	back_pressed.emit()
