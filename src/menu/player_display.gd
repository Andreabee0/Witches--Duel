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
var selections: Selections
var cursor: Node2D
var spells: Array[SpellIcon] = []
var perk: Array[PerkIcon] = []


func set_color(value: PlayerColor) -> void:
	color = value
	if cursor:
		cursor.color = color.secondary
	for slot in spells:
		slot.color = color.secondary
	for p in perk:
		p.color = color.secondary
	$Margin/MainContainer/PlayerSprites/Belt.modulate = color.secondary
	$Margin/MainContainer/PlayerSprites/Robe.modulate = color.primary


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
	var starting_anchor: Control = $Margin/MainContainer/PlayerSprites
	var pos := starting_anchor.global_position + starting_anchor.size * Vector2(0.4, -0.1)
	cursor.global_position = pos


func set_selections(value: Selections) -> void:
	if selections:
		Util.checked_disconnect(selections.changed, selections_changed)
	selections = value
	if selections:
		Util.checked_connect(selections.changed, selections_changed)
		if not cursor:
			cursor = BASE_CURSOR.instantiate()
			get_tree().root.add_child(cursor)
			cursor.color = color.secondary
			# when loading a menu with already joined players,
			# the layout of the player sprite doesn't seem to be done immediately
			call_deferred("set_cursor_to_start")
		cursor.selections = selections
		selections_changed()
	elif cursor:
		cursor.queue_free()
		cursor = null


func get_spell_better_sorting(index: int) -> SpellIcon:
	if spells.size() % 2 == 1 and index == spells.size() - 1:
		return spells[index]
	if index % 2 == 0:
		return spells[index + 1]
	return spells[index - 1]


func selections_changed() -> void:
	if spells.size() >= selections.spells.size():
		var i := 0
		for button in selections.spells:
			get_spell_better_sorting(i).button = button
			i += 1
		for j in range(i, spells.size()):
			get_spell_better_sorting(i).button = -1
	if not perk.is_empty():
		perk[0].selection = selections.perk.name if selections.perk else ""


func set_spell_icons(symbols: bool) -> void:
	var i := 0
	for button in selections.spells:
		var icon: SpellIcon = get_spell_better_sorting(i)
		if symbols:
			icon.set_symbol(selections.spells[button].name)
		else:
			icon.set_button(button)
		i += 1


func get_device() -> int:
	return selections.device.device if selections else -2


func _ready() -> void:
	set_perk_slots(perk_slots)
	set_spell_slots(spell_slots)


func _process(_delta: float) -> void:
	if selections:
		if selections.device.is_action_just_pressed("multi_ui_shift"):
			set_spell_icons(true)
		elif selections.device.is_action_just_released("multi_ui_shift"):
			set_spell_icons(false)


func _exit_tree() -> void:
	if cursor:
		cursor.queue_free()
