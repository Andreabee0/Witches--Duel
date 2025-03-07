extends Control

const BASE_HUD := preload("res://scenes/player_hud.tscn")

var huds: Array[PlayerHud] = []

@onready var container = $Margin/Container


func _ready() -> void:
	Util.update_object_count(huds, Players.get_joined_count(), make_hud)


func make_hud() -> PlayerHud:
	var instance: PlayerHud = BASE_HUD.instantiate()
	container.add_child(instance)
	var player := Players.joined_order[huds.size()]
	instance.set_player(player)
	return instance
