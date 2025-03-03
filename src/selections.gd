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
	instance.device = device
	parent.add_child(instance)


func get_additive(stat: int) -> float:
	var ret = perk._get_additive(stat) if perk else 0.0
	for spell in spells:
		if spell != null:
			ret += spell._get_additive(stat)
	return ret


func get_multiplicative(stat: int) -> float:
	var ret = perk._get_multiplicative(stat) if perk else 1.0
	for spell in spells:
		if spell != null:
			ret *= spell._get_multiplicative(stat)
	return ret


func get_stat(stat: int) -> float:
	return (PlayerStats.base[stat] + get_additive(stat)) * get_multiplicative(stat)


func has_perk() -> bool:
	return perk != null


func has_spells() -> bool:
	return spells.size() == get_stat(PlayerStats.SPELL_SLOTS)


func cursor_in(area: Rect2) -> bool:
	return area.has_point(cursor_position)


func is_pressing() -> bool:
	return device.is_action_pressed("multi_ui_accept")


func has_pressed() -> bool:
	return device.is_action_just_released("multi_ui_accept")
