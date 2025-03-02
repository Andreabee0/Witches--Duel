class_name Selections
extends RefCounted

signal changed

const BASE_PLAYER := preload("res://scenes/player.tscn")

var device: DeviceInput
var cursor_position := Vector2.INF
# button to spell
var spells := {}
var perk: BasePerk


func set_spell(button: int, value: BaseSpell) -> void:
	spells[button] = value
	changed.emit()


func set_perk(value: BasePerk) -> void:
	perk = value
	changed.emit()


func _init(device_value: DeviceInput) -> void:
	device = device_value


func create_player(parent: Node2D) -> void:
	var instance = BASE_PLAYER.instantiate()
	parent.add_child(instance)
	var stats: PlayerStats = instance.get_node("Stats")
	stats.player_id = device.device
	stats.spells = spells
	stats.perk = perk
