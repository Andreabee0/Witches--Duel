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


func set_selections(value: Selections) -> void:
	if selections:
		Util.checked_disconnect(selections.changed, selections_changed)
	selections = value
	if selections:
		Util.checked_connect(selections.changed, selections_changed)
		if not cursor:
			cursor = BASE_CURSOR.instantiate()
			get_tree().root.add_child(cursor)
			var starting_anchor: Control = $Margin/MainContainer/PlayerSprites
			cursor.global_position = (
				starting_anchor.global_position + starting_anchor.size * Vector2(0.4, -0.1)
			)
			cursor.color = color.secondary
		cursor.selections = selections
	elif cursor:
		cursor.queue_free()
		cursor = null


func selections_changed() -> void:
	var i := 0
	for button in selections.spells:
		spells[i].selection = button
		i += 1
	for j in range(i, spells.size()):
		spells[i].selection = -1
	if not perk.is_empty():
		perk[0].selection = selections.perk.name if selections.perk else ""


func get_device() -> int:
	return selections.device.device if selections else -2


func _ready() -> void:
	set_perk_slots(perk_slots)
	set_spell_slots(spell_slots)
