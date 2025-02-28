@tool
class_name PerkSelectMenu
extends Control

signal back_pressed

const BASE_PLAYER := preload("res://scenes/components/player_selections.tscn")

@export var player_count := 0:
	set = set_player_count

var players: Array[Node] = []


func set_player_count(value: int):
	player_count = value
	VariableObjects.update_object_count(players, player_count, make_player)


func make_player() -> Node:
	var ret: PlayerSelections = BASE_PLAYER.instantiate()
	$VerticalContainer/PlayersContainer.add_child(ret)
	ret.color = Color.GRAY
	ret.spell_slots = 0
	ret.perk_slots = 1
	return ret


func update_player_count():
	set_player_count(Players.get_device_count())


func _ready() -> void:
	if Engine.is_editor_hint():
		set_player_count(player_count)
	else:
		update_player_count()
		Players.devices_changed.connect(update_player_count)


func _on_back_pressed():
	back_pressed.emit()
