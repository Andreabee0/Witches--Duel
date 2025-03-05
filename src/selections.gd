class_name Selections
extends RefCounted

signal changed

enum Buttons {
	LEFT_TRIGGER,
	RIGHT_TRIGGER,
	LEFT_BUTTON,
	RIGHT_BUTTON,
}

const BASE_PLAYER := preload("res://scenes/player.tscn")

static var button_actions := [
	"use_action_lt",
	"use_action_rt",
	"use_action_lb",
	"use_action_rb",
]

static var button_textures: Array[Texture2D] = [
	preload("res://sprites/menu/left_trigger.png"),
	preload("res://sprites/menu/right_trigger.png"),
	preload("res://sprites/menu/left_button.png"),
	preload("res://sprites/menu/right_button.png"),
]

var device: DeviceInput
var cursor_position := Vector2.INF
# button to spell instance
var spells := {}
var perk: BasePerk


func set_spell(button: int, value: BaseSpell) -> void:
	if button not in spells and spells.size() >= get_stat(PlayerStats.SPELL_SLOTS):
		var key: int = spells.keys()[0]
		print("new button makes too many spells; erasing button ", Buttons.keys()[key])
		spells.erase(key)
	value.player = device.device
	spells[button] = value
	changed.emit()


func set_perk(value: BasePerk) -> void:
	perk = value
	changed.emit()


func _init(device_value: DeviceInput) -> void:
	device = device_value


func create_player(parent: Node) -> void:
	var instance = BASE_PLAYER.instantiate()
	instance.selections = self
	parent.add_child(instance)


func get_additive(stat: int) -> float:
	var ret = perk._get_additive(stat) if perk else 0.0
	for spell in spells.values():
		ret += spell._get_additive(stat)
	return ret


func get_multiplicative(stat: int) -> float:
	var ret = perk._get_multiplicative(stat) if perk else 1.0
	for spell in spells.values():
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


func buttons_has_pressed(filter := false) -> Array[int]:
	var ret: Array[int] = []
	for button: int in Buttons.values():
		if filter and not button in spells:
			continue
		if device.is_action_just_released(button_actions[button]):
			ret.append(button)
	return ret


func buttons_pressed(filter := false) -> Array[int]:
	var ret: Array[int] = []
	for button: int in Buttons.values():
		if filter and not button in spells:
			continue
		if device.is_action_pressed(button_actions[button]):
			ret.append(button)
	return ret


func has_spell(spell: String) -> bool:
	for instance in spells.values():
		if instance.name == spell:
			return true
	return false
