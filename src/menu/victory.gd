extends Control

const BASE_PLAYER_SPRITE = preload("res://scenes/components/ui_player.tscn")

var lost_players: Array[int] = []
var player_sprites: Array[UiPlayer] = []

@onready var winner := $Margin/Container/Winner
@onready var players_container := $Margin/Container/SubContainer


func _ready() -> void:
	for player in Players.joined_order:
		if Players.info[player].get_remaining_health() > 0:
			winner.set_color(Players.colors[player])
			continue
		lost_players.append(player)
	Util.update_object_count(player_sprites, lost_players.size(), make_player_sprite)


func make_player_sprite() -> UiPlayer:
	var ret: UiPlayer = BASE_PLAYER_SPRITE.instantiate()
	players_container.add_child(ret)
	var player := lost_players[player_sprites.size()]
	ret.set_color(Players.colors[player])
	ret.set_animated(false)
	return ret

