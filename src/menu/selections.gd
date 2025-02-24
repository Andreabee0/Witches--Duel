class_name Selections
extends RefCounted

var player := preload("res://scenes/player.tscn")

var spells: Array[BaseSpell]
var perk: BasePerk


func create_player(parent: Node2D, id: int):
	var instance = player.instantiate()
	parent.add_child(instance)
	var stats: PlayerStats = instance.get_node("Stats")
	stats.player_id = id
	stats.perk = perk
