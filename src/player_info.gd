class_name PlayerInfo
extends RefCounted

signal changed
signal damaged(amount: int)

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

var damage_taken := 0
var last_hit_time := -INF
var last_dash_time := -INF


func set_spell(button: int, value: BaseSpell) -> void:
	if button not in spells and spells.size() >= get_stat(PlayerStats.SPELL_SLOTS):
		var key: int = spells.keys()[0]
		print("new button makes too many spells; erasing button ", Buttons.keys()[key])
		spells.erase(key)
	value.player = device.device
	spells[button] = value
	changed.emit()


func set_perk(value: BasePerk) -> void:
	value.player = device.device
	perk = value
	changed.emit()


func _init(device_value: DeviceInput) -> void:
	device = device_value


func create_player(parent: Node) -> void:
	var instance = BASE_PLAYER.instantiate()
	instance.info = self
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


func update_perk(delta: float):
	if perk:
		perk.update(delta)


func can_be_hit() -> bool:
	if Time.get_ticks_msec() - last_hit_time > get_stat(PlayerStats.IFRAME_DURATION) * 1000:
		last_hit_time = Time.get_ticks_msec()
		return true
	return false


func should_dash() -> bool:
	if device.is_action_pressed("move_extra"):
		if Time.get_ticks_msec() - last_dash_time > get_stat(PlayerStats.DASH_COOLDOWN) * 1000:
			last_dash_time = Time.get_ticks_msec()
			return true
	return false


func handle_hit(damage: int) -> bool:
	if not can_be_hit():
		return false
	if randf_range(0, 1) < get_stat(PlayerStats.DODGE_CHANCE):
		return false
	var modified_damage := int(damage * get_stat(PlayerStats.DAMAGE_TAKEN))
	damage_taken += modified_damage
	damaged.emit(modified_damage)
	return true


func heal(amount: int) -> void:
	damage_taken -= amount
	if damage_taken < 0:
		damage_taken = 0
	damaged.emit(-amount)


func get_remaining_health() -> int:
	return int(get_stat(PlayerStats.HEALTH)) - damage_taken
