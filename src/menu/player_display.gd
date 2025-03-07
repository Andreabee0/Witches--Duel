@tool
class_name PlayerSelections
extends Container

const BASE_CURSOR := preload("res://scenes/components/cursor.tscn")
const BASE_SPELL_SLOT := preload("res://scenes/components/spell_icon.tscn")
const BASE_PERK_SLOT := preload("res://scenes/components/perk_icon.tscn")

@export var spell_slots := 0:
	set = set_spell_slots

@export var perk_slots := 0:
	set = set_perk_slots

var color := PlayerColor.new()
var player_info: PlayerInfo
var cursor: Node2D
var spells: Array[SpellIcon] = []
var perk: Array[PerkIcon] = []
var showing_symbols := false

@onready var player_sprite: UiPlayer = $Margin/MainContainer/Player


func set_color(value: PlayerColor) -> void:
	color = value
	if cursor:
		cursor.color = color.secondary
	for slot in spells:
		slot.color = color.secondary
	for p in perk:
		p.color = color.secondary
	player_sprite.set_color(color)


func set_spell_slots(value) -> void:
	spell_slots = clamp(value, 0, 4)
	Util.update_object_count(spells, spell_slots, make_spell_slot)


func set_perk_slots(value) -> void:
	perk_slots = clamp(value, 0, 1)
	Util.update_object_count(perk, perk_slots, make_perk_slot)


func make_spell_slot() -> Node:
	var ret := BASE_SPELL_SLOT.instantiate()
	$Margin/MainContainer/SpellsContainer.add_child(ret)
	ret.color = color.secondary
	return ret


func make_perk_slot() -> Node:
	var ret := BASE_PERK_SLOT.instantiate()
	$Margin/MainContainer/PerkContainer.add_child(ret)
	ret.color = color.secondary
	return ret


func set_cursor_to_start():
	var starting_anchor: Control = $Margin/MainContainer/Player
	var pos := starting_anchor.global_position + starting_anchor.size * Vector2(0.4, -0.1)
	cursor.global_position = pos


func set_player_info(value: PlayerInfo) -> void:
	if player_info:
		Util.checked_disconnect(player_info.changed, player_info_changed)
	player_info = value
	if player_info:
		Util.checked_connect(player_info.changed, player_info_changed)
		if not cursor:
			cursor = BASE_CURSOR.instantiate()
			get_tree().root.add_child(cursor)
			cursor.color = color.secondary
			# when loading a menu with already joined players,
			# the layout of the player sprite doesn't seem to be done immediately
			call_deferred("set_cursor_to_start")
		cursor.player_info = player_info
		player_info_changed()
	elif cursor:
		cursor.queue_free()
		cursor = null


func get_spell_better_sorting(index: int) -> SpellIcon:
	if spells.size() % 2 == 1 and index == spells.size() - 1:
		return spells[index]
	if index % 2 == 0:
		return spells[index + 1]
	return spells[index - 1]


func player_info_changed() -> void:
	set_spell_icons(showing_symbols)
	if not perk.is_empty():
		perk[0].selection = player_info.perk.name if player_info.perk else ""


func set_spell_icons(symbols: bool) -> void:
	showing_symbols = symbols
	if not spells.size() >= player_info.spells.size():
		return
	var i := 0
	for button in player_info.spells:
		var icon: SpellIcon = get_spell_better_sorting(i)
		if symbols:
			icon.set_symbol(player_info.spells[button].name)
		else:
			icon.set_button(button)
		i += 1
	for j in range(i, spells.size()):
		get_spell_better_sorting(j).button = -1


func get_device() -> int:
	return player_info.device.device if player_info else -2


func _ready() -> void:
	set_perk_slots(perk_slots)
	set_spell_slots(spell_slots)


func _process(_delta: float) -> void:
	if player_info:
		if player_info.device.is_action_just_pressed("multi_ui_shift"):
			set_spell_icons(true)
		elif player_info.device.is_action_just_released("multi_ui_shift"):
			set_spell_icons(false)


func _exit_tree() -> void:
	if cursor:
		cursor.queue_free()
